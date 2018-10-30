require 'rails_helper'

RSpec.describe "Visitor", type: :feature do
  context "Capabilities" do
    before :each do
      @admin = Admin.create!(
        email: Faker::Internet.email,
        password: Faker::Internet.password
      )
      @setting = @admin.setting
      @setting.admin_id = @admin.id
      @setting.name = Faker::Name.name
      #TODO profile_pic
      @setting.tagline = "is building things for Bitcoin"
      @setting.main_info = "Come support my work."
      @setting.btcpayserver_url = "https://example.com"
      @setting.save
      @tier = Tier.create!(
        admin_id: @admin.id,
        description: "Tier 1 Description",
        amount_currency: 'USD',
        amount_cents: 1000
      )
    end


    # Regular top page visitors

    it "should see the contents on main page" do
      visit '/'
      top_sentence = @setting.name + ' ' + @setting.tagline
      expect( page ).to have_content( top_sentence )
      expect( page ).to have_content( @setting.main_info )
      expect( page ).to have_content( @tier.description )
      expect( page ).to have_content( @tier.amount.format )
    end

    it "should not be able to access admin related things" do
      visit '/admin'
      expect( current_path ).to eq( '/admins/sign_in' )
    end

    it "should be able to visit their recurring payment link page" do
      new_subscription = Subscription.create!(
        name: Faker::Name.name, 
        email: Faker::Internet.email, 
        last_payment_date: nil, 
        last_email_reminder: nil, 
        status: nil, 
        amount_cents: 1000, 
        amount_currency: "USD", 
        invoice_id: nil, 
        invoice_status: nil, 
        tier_id: @tier.id, 
        invoice_url: nil, 
        uuid: SecureRandom.uuid
      )
      visit '/subscription_link/' + new_subscription.uuid
      expect( page.status_code ).not_to eq 404
      expect( page ).to have_content( 'Go to payment' )
      expect( page ).to have_content( new_subscription.amount.format )
    end

    pending "should not be able to make changes to DB"

    # About to pay customers
    pending "should receive an email with a payment link"
    pending "should be redirected to a BTCPayServer invoice link"
    pending "can see the status of her Invoice"

    # Paid subscribers
    it "should be able to login to their supporter page" do
      visit '/user/index'
      expect( current_path ).to eq( '/users/sign_in' )
      user = User.create!(
        email: "test@example.com", 
        password: "testtest"
      )
      fill_in 'user[email]', with: 'test@example.com'
      fill_in 'user[password]', with: 'testtest'
      click_button 'Sign in'
      expect( current_path ).to eq '/user/index'
    end

    pending "should see only posts that are appropriate to their Tier level"

    pending "should be able to change their password"
  end
end
