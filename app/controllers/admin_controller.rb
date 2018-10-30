class AdminController < ApplicationController
  include  AdminHelper

  def index
    @goals = current_admin.goals
    @tiers = current_admin.tiers
    @settings = current_admin.setting
    @posts = Post.all
    @tier_ids = []
    if @posts
      @posts.each do |p|
        tiers = []
        p.tier_id.split(',').each do |t|
          x = t.split(':')
          if x[1] == "true"
            tiers.push(x[0])
          end
        end
        @tier_ids.push(tiers)
      end
    end
    @subscriptions = Subscription.all
    @active_subscriptions = Subscription.where(status: "active")
    #TODO
    @amount_btc = '0 BTC'
    @amount_usd = '$ 0'
  end

  # Settings
  def settings
    @currencies = ['USD', 'JPY', 'BTC']
    @setting = current_admin.setting
  end

  def settings_update
    @setting = current_admin.setting

    # Attaching a profile pic
    if !( (params[:profile_pic] == '')||
        (params[:profile_pic] == nil) )
      if @setting.profile_pic.attached?
        @setting.profile_pic.purge
      end
      @setting.profile_pic.attach(params[:profile_pic])
    end

    # Attaching a header pic
    if !( (params[:header_pic] == '')||
        (params[:header_pic] == nil) )
      if @setting.header_pic.attached?
        @setting.header_pic.purge
      end
      @setting.header_pic.attach(params[:header_pic])
      @setting.header_pic.blob.update(filename: "headerPic.#{@setting.header_pic.filename.extension}")
    end

    # Updating settings
    if @setting.update( setting_params )
      render action: "settings", notice: 'Settings was updated.'
    else
      render action: "settings", notice: 'Settings was not updated.'
    end
  end

  # Email templates
  def email_templates
    @setting = current_admin.setting
  end

  def email_templates_update
    @setting = current_admin.setting
    if @setting.update( setting_params )
      render action: "email_templates", notice: 'Email templates were updated.'
    else
      render action: "email_templates", notice: 'Email templates were not updated.'
    end
  end

  def getPairing
    url = params['_json'][0]
    pair_token = params['_json'][1]
    pem, result = getPairToken( url, pair_token )
    #TODO clean up & validation
    if !result.nil? && !result[0]['token'].nil?
      setting = current_admin.setting
      setting.btcpayserver_url = url
      setting.btcpayserver_pem = pem
      setting.btcpayserver_keypair = pair_token
      setting.btcpayserver_token = result[0]["token"]
      setting.save
    end
    respond_to do |format|
      format.json { render json: {"pem"=>pem, "result"=>result} }
    end
  end

  # Reports
  def reports
  end

  private

  def setting_params
    params.require(:setting).permit(
      :name, :profile_pic, :header_pic, :tagline, :main_info, :currency, :admin_id, :domain,
      :btcpayserver_url, :btcpayserver_keypair, :btcpayserver_token, :ga_script,
      :youtube_link, :embedded_media,
      :origin_email, :invoice_email, :thankyou_email, :recurring_payment_link_email, 
      :reminder_email, :goodbye_email, :user_credentials_email,
      :mail_host, :mail_user_name, :mail_password, :mail_domain, :mail_address, 
      :mail_port, :mail_authentication, :mail_enable_starttls_auto
    )
  end

  #TODO
  def confirm_invoice_details(details)
    # get_invoice(details["id"])
    #
  end
end
