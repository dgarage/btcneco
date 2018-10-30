require 'bitpay_sdk'

class HomeController < ApplicationController
  #skip_before_action :verify_authenticity_token, only: :api_notification
  #before_action :verify_btcpayserver_source, only: :api_notification

  def index
    admin = Admin.last
    #TODO Only show current lowest goal
    @goals = (!admin.nil? && !admin.goals.empty?) ? admin.goals : nil
    @goal  = @goals.last
    @tiers = (!admin.nil? && !admin.tiers.empty?) ? admin.tiers : nil
    @domain = request.protocol + request.host_with_port
    #TODO Sync currency units
    @tier_display_amount = []
    if @tiers
      @tiers.each_with_index do |t, index|
        if t.amount.currency == 'BTC'
          @tier_display_amount[index] = t.amount.dollars.to_s + ' BTC'
        else
          @tier_display_amount[index] = t.amount.format
        end
      end
    end
    @name  = (!admin.nil? && !admin.setting.nil? && !admin.setting.name.nil? && admin.setting.name != "") ? admin.setting.name : "Satoshi Nakamoto"
    @tagline = (!admin.nil? && !admin.setting.nil? && !admin.setting.tagline.nil? && admin.setting.tagline != "") ? admin.setting.tagline : "is building Bitcoin."
    #TODO change to a proper header & profile pic
    @profile_pic = admin.setting.profile_pic.attached? ? url_for(admin.setting.profile_pic) : ActionController::Base.helpers.asset_path('defaultProfilePic.png')
    @header_pic = admin.setting.header_pic.attached? ? url_for(admin.setting.header_pic) : ActionController::Base.helpers.asset_path('jumbotronTest.jpg')
    @main_info = (!admin.nil? && !admin.setting.nil? && !admin.setting.main_info.nil? && admin.setting.main_info != "") ? admin.setting.main_info : "No content yet!"
    neco_pic_path = '<div class="col-lg-8"><img src="' + ActionController::Base.helpers.asset_path("BTCnecoMedia.png") + '" ></div>'
    @embedded_media = (!admin.nil? && !admin.setting.nil? && !admin.setting.embedded_media.nil? && admin.setting.embedded_media != "") ? admin.setting.embedded_media : neco_pic_path

    @public_posts = Post.where(public_post:"true") 
    @public_posts = [] if @public_posts.empty?

    # Counting patrons
    #TODO cache as a parameter of Admin so we don't need to hit DB
    @patrons = {}
    @total_patrons = 0
    @total_monthly_btc_amount = 0
    #TODO Move to helper & make tests
    if !@tiers.nil? && @tiers.count > 0
      @tiers.each do |t|
        s = Subscription.where( tier_id:t.id, status: 'active' )
        @total_patrons += s.count
        @patrons[t.id] = s.count
        if t.amount_currency == 'BTC'
          s.each {|x| @total_monthly_btc_amount += x.amount}
        else
          #TODO Probably there's a better way to do this
          s.each do |subscription|
            last_invoice = subscription.invoices.last
            if last_invoice.invoice_status
              if (last_invoice.invoice_status == 'complete') || 
                  (last_invoice.invoice_status == 'paid') || 
                  (last_invoice.invoice_status == 'confirmed')
                @total_monthly_btc_amount += Money.new( last_invoice.satoshi_amount, 'BTC' )
              end
            end
          end
        end
      end
    end
    g = Money.new(@goal.satoshi_amount, 'BTC')
    @goal_progress = ((@total_monthly_btc_amount / g) * 100).to_i.to_s + '%'
    @total_monthly_btc_amount = @total_monthly_btc_amount.dollars.to_s + ' BTC'
  end

  def generateInvoice
    #TODO Filter exceptions for empty/false parameters
    admin = Admin.last
    tier  = params['tier']
    tier_id = params['tier_id']
    amount = params['amount'].to_f
    #TODO Exception for possible Duration trickery
    # Ensure that Duration is a valid number
    duration = params['duration'].to_i
    currency = params['currency']
    total_amount = Money.new(amount*duration, currency)

    # User email
    email = params['email']
    anon_subscriber = false
    if (email == '')||(email == nil)
      anon_subscriber = true
      emails_array = User.all.map{|x| x.email}
      loop do
        domain = admin.setting.domain ? admin.setting.domain : 'btcneco.com'
        email  = SecureRandom.hex(6) + '@' + domain
        break if !emails_array.include?(email)
      end
    end

    # User name
    name  = params['name']
    if (name == '')||(name == nil)
      name = email
    end

    # Start BTCPay sequence
    client = BitPay::SDK::Client.new(
      api_uri: admin.setting.btcpayserver_url,
      pem: admin.setting.btcpayserver_pem,
      #tokens: {"merchant"=>admin.setting.btcpayserver_token},
      #params: {"tokens" => {"merchant"=>admin.setting.btcpayserver_token}},
      debug: true
    )
    order_id = generate_order_id
    res = client.create_invoice(
      price: total_amount.format(symbol:''),
      currency: currency,
      facade: 'merchant',
      params: {
        notificationUrl: unauthenticated_root_url + 'api_notification?orderId=' + order_id,
        redirectUrl: unauthenticated_root_url + 'subscription_order_received?orderid=' + order_id,
        orderId: order_id,
        "buyer" => {
          "email" => email,
          "name"  => name
        }
      }
    )
    # Log response
    Btcpayserverlog.create!(message:res.inspect)

    # Generate Subscription, if one doesn't exist with that email
    subscription = Subscription.find_by(email: email)
    if subscription.nil? && !res.nil?
      subscription = Subscription.new
      subscription.name  = name if res['buyer']['name'] == name
      subscription.email = email if res['buyer']['email'] == email
      subscription.amount_currency = currency if res['currency'] == params['currency']
      #TODO Check price with internal invoice
      subscription.amount = res['price']
      subscription.tier_id = tier_id if tier_id
      subscription.invoice_id = res['id']
      subscription.invoice_status = res['status']
      subscription.invoice_url = res['url']
      subscription.status = res['status']
      subscription.uuid = SecureRandom.uuid
      subscription.anonymous = anon_subscriber
      subscription.save!
    end

    # Generate Invoice
    invoice = Invoice.create!(
      amount_currency: currency,
      amount: total_amount.format(symbol:''),
      tier_id: tier_id,
      invoice_id: res['id'],
      invoice_status: res['status'],
      invoice_url: res['url'],
      subscription_id: subscription.id,
      invoiceTime: Time.at(res['invoiceTime']),
      expirationTime: Time.at(res['expirationTime']),
      order_id: order_id,
      duration: duration.to_s,
      satoshi_amount: res['paymentSubtotals']['BTC']
    )

    # Send invoice to email
    if !anon_subscriber
      SubscriptionMailer.with(subscriber: subscription, invoice: invoice).send_invoice.deliver_later
    end

    #TODO Exception responses
    respond_to do |format|
      format.json {render json: {"url"=>res["url"]}}
    end
  end

  # Redirect after payment from BTCPayServer
  def subscription_order_received
    @invoice = Invoice.find_by( order_id: params['orderid'] )
    @subscription = @invoice.subscription
    @anonymous_user = @subscription.anonymous

    # If Subscription doesn't exist, should redirect to 404
    if @invoice && @subscription
      @invoice, @subscription = compare_internal_invoice_status( @invoice )

      # Anonymous Users
      if @anonymous_user #TODO Filter out expired subscription
        user = User.find_by(email: @subscription.email)
        @temp_password = SecureRandom.hex(10)
        user.password  = @temp_password
        user.save!
        #TODO Maybe limit the number of times this occurs
      end
    else
      render status: 404
    end
  end

  #TODO Probably not necessary
  def subscription_order_received_post
    Btcpayserverlog.create!(message:params.inspect)
  end
  ###

  # Recurring payment link
  def subscription_link
    @subscription = Subscription.find_by uuid: params['id']
    @tier = Tier.find(@subscription.tier_id)
    if @tier
      if @tier.amount.currency == 'BTC'
        @tier_display_amount = @tier.amount.dollars.to_s + ' BTC'
      else
        @tier_display_amount = @tier.amount.format
      end
    end
  end

  # Notification URL
  def api_notification
    #TODO Testing sucks
    Btcpayserverlog.create!(message:params.inspect)
    if params['orderid']
      compare_internal_invoice_status( Invoice.find_by(order_id: params['orderid']) )
    end
    render status: 200
  end

  def api_notification_post
    Btcpayserverlog.create!(message:params.inspect)
  end

  private

  ###
  # NOTE
  # BTCPayServer invoice states:
  # new, paid, confirmed, complete, expired, invalid
  # https://bitpay.com/docs/invoice-states

  def get_invoice_details( invoiceId ) 
    admin = Admin.last
    client = BitPay::SDK::Client.new(
      api_uri: admin.setting.btcpayserver_url,
      pem: admin.setting.btcpayserver_pem,
      params: {"tokens" => {"merchant"=>admin.setting.btcpayserver_token}},
      debug: true
    )
    res = client.get_invoice(id: invoiceId)
    return res
  end

  def compare_internal_invoice_status( internal_invoice )
    btcpayserver_invoice = get_invoice_details( internal_invoice.invoice_id )
    subscription = internal_invoice.subscription

    # Sanity Check on ID
    if ((internal_invoice.invoice_id == btcpayserver_invoice['id'])&&
        (internal_invoice.order_id == btcpayserver_invoice['orderId']))

      # Check if BTCPay's Invoice status has changed
      if (internal_invoice.invoice_status != btcpayserver_invoice['status'])

        # Update subscription if invoice is actually Paid
        # TODO Prevent bug where the User renews a subscription using an old paid Invoice
        if (btcpayserver_invoice['status'] == 'paid')||
            (btcpayserver_invoice['status']== 'complete')||
            (btcpayserver_invoice['status']== 'confirmed')

          # TODO check subscription length validity
          # if @subscription.end_date < current_date

          #TODO Tests & Re-check
          # Check if Internal Invoice already redeemed
          if (internal_invoice.redeemed == nil)||(internal_invoice.redeemed == false)

            # Activate Subscription
            subscription.status = "active"
            subscription.expires_on = Time.now + internal_invoice.duration.to_i.months
            subscription.save!
            #TODO Set reasonable email time

            # Set Invoice to redeemed
            internal_invoice.redeemed = true
            internal_invoice.save!

            # Send Thank you email
            if !subscription.anonymous
              SubscriptionMailer.with( subscriber: subscription, invoice: internal_invoice )
                .thankyou_email.deliver_later

              # TEST
              #RemindSubscriptionJob.set( wait: internal_invoice.duration.to_i.seconds )
              #  .perform_later( subscription )

              RemindSubscriptionJob.set( wait: internal_invoice.duration.to_i.months )
                .perform_later( subscription )
            end
          end

          # Add user for BTCneco
          if (User.find_by(email:subscription.email).nil?)
            create_user_for( subscription )
          end
        end

        # Update Internal Invoice to match
        internal_invoice.invoice_status = btcpayserver_invoice['status']
        internal_invoice.save!
      end
    else
      #TODO Give warning that something doesn't add up
    end
    return internal_invoice, subscription
  end

  def generate_order_id
    orderIds = Invoice.pluck(:order_id)
    id = String.new
    loop do
      id = SecureRandom.hex(16)
      break unless orderIds.include? id
    end
    return id
  end

  def create_user_for(subscription)
    pass = SecureRandom.hex(10)
    u = User.create!(email:subscription.email, password:pass, subscription_id:subscription.id)
    if !subscription.anonymous
      SubscriptionMailer.with(subscriber: subscription, password:pass).send_user_credentials.deliver_later
    end
  end

  #def verify_btcpayserver_source
  #  #TODO
  #  #Can't receive POST messages from BTCPay unless in production
  #  p "*********"
  #  p request.referrer
  #  p "*********"
  #end
end
