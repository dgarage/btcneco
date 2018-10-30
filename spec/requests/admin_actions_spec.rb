require 'rails_helper'

RSpec.describe "Admin", type: :feature do
  context "Capabilities" do
    before :each do
      @admin = Admin.create!( email:"test@example.com", password:"asdfasdf" )
    end

    it "signs in as a Admin and goes to Dashboard" do
      visit new_admin_session_url
      fill_in 'admin[email]', with:"test@example.com"
      fill_in 'admin[password]', with:"asdfasdf"
      click_button 'Sign in'
      expect( page ).to have_content( 'Dashboard' )
    end

    it "can see Goals, input new Goal, and edit" do
      # Login
      visit new_admin_session_url
      fill_in 'admin[email]', with:"test@example.com"
      fill_in 'admin[password]', with:"asdfasdf"
      click_button 'Sign in'

      # Goals page
      expect( page ).to have_content( 'Goals' )
      click_link 'link_goal'
      expect( Goal.count ).to eq 0
      #expect( page ).to have_content( 'No Goals yet!' )

      # New Goal page
      click_link "Create new goal"
      expect( current_path ).to eq '/admin/goals/new'
      fill_in 'goal_description', with: "TEST Goal Description"
      fill_in 'goal_satoshi_amount', with: 200000000
      find('input[name="commit"]').click
      expect( Goal.count ).to eq 1
      expect( Goal.last.description ).to eq "TEST Goal Description"
      expect( Goal.last.satoshi_amount ).to eq 200000000

      # Back to Goals page
      expect( page ).to have_content( "TEST Goal Description" )
      #expect( page ).not_to have_content( "No Goals yet!" )
      #TODO Sanitize input!! kinda conflicted since we want MarkDown

      # Check content on Main Page
      visit '/'
      expect( page ).to have_content( 'TEST Goal Description' )
      expect( page ).to have_content( '2 BTC' )
    end

    it "can see Tiers, input new Tier, and edit" do
      # Login
      visit new_admin_session_url
      fill_in 'admin[email]', with:"test@example.com"
      fill_in 'admin[password]', with:"asdfasdf"
      click_button 'Sign in'

      # Tiers page
      expect( page ).to have_content( 'Tiers' )
      click_link 'link_tier'
      expect( Tier.count ).to eq 0

      # New Tier page
      click_link "Create new tier"
      expect( current_path ).to eq '/admin/tiers/new'
      fill_in 'tier_description', with: "TEST Tier Description"
      fill_in 'tier_amount_cents', with: 1000000
      select 'BTC', from: 'tier_amount_currency'
      find('input[name="commit"]').click
      expect( Tier.count ).to eq 1
      expect( Tier.last.description ).to eq "TEST Tier Description"
      expect( Tier.last.amount_cents ).to eq 1000000
      expect( Tier.last.amount_currency ).to eq 'BTC'

      # Back to Tiers page
      expect( page ).to have_content( "TEST Tier Description" )

      # Check content on Main Page
      visit '/'
      expect( page ).to have_content( "TEST Tier Description" )
      # TODO Remove trailing zeros for BTC
      expect( page ).to have_content '0.01000000'
    end

    it "can see Settings, and edit/save parameters" do
      # Login
      visit new_admin_session_url
      fill_in 'admin[email]', with:"test@example.com"
      fill_in 'admin[password]', with:"asdfasdf"
      click_button 'Sign in'

      # Settings page
      expect( page ).to have_content( 'Settings' )
      click_link 'link_settings'
      expect( current_path ).to eq '/admin/settings'
      fill_in 'setting_name', with: "Test Name"
      # TODO Profile Pic
      #fill_in 'setting_profile_pic'
      fill_in 'setting_tagline', with: "is building things."
      fill_in 'setting_main_info', with: "TEST Content"
      select 'USD', from: 'setting_currency'
      # TODO Testing Keypair
      #fill_in 'setting_btcpayserver_keypair'
      find('input[name="commit"]').click
      expect( Setting.last.name ).to eq "Test Name"
      expect( Setting.last.tagline ).to eq "is building things."
      expect( Setting.last.main_info ).to eq "TEST Content"
      expect( Setting.last.profile_pic ).to include "defaultProfilePic" #TODO
      expect( Setting.last.currency ).to eq "USD"
      expect( Setting.last.admin_id ).to eq Admin.last.id

      # Check it's reflected on main page
      visit '/'
      expect( page ).to have_content "Test Name is building things."
      expect( page ).to have_content "TEST Content"
    end

    # Customer related things
    pending "can see/edit Invoices"
    pending "can see/edit Subscriptions"
    pending "can see/edit Emails"
    pending "can see/edit Users"
  end
end
