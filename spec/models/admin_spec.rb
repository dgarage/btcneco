require 'rails_helper'

RSpec.describe Admin, type: :model do
  # Admin is created by Devise, so we're only testing additions
  context "Properties" do
    it "has the basic properties" do
      admin = Admin.create!(
        email: Faker::Internet.email,
        password: Faker::Internet.password
      )
      expect( admin ).not_to be_nil
    end

    it "connected to goals" do
      admin = Admin.create(
        email: Faker::Internet.email,
        password: Faker::Internet.password
      )
      goals = Goal.create(
        admin_id: admin.id,
        description: "Test description",
        satoshi_amount: 10000000
      )
      expect( admin.goals ).not_to be_nil
      expect( admin.goals.first.class.name ).to eq "Goal"
      expect( admin.goals.first.description ).to eq "Test description"
      expect( admin.goals.first.satoshi_amount ).to eq 10000000
    end

    it "connected to tiers" do
      admin = Admin.create(
        email: Faker::Internet.email,
        password: Faker::Internet.password
      )
      tiers = Tier.create(
        admin_id: admin.id,
        description: "Test description",
        amount_currency: 'BTC',
        amount_cents: 1000000
      )
      expect( admin.tiers ).not_to be_nil
      expect( admin.tiers.last.class ).to eq Tier
      expect( admin.tiers.last.description ).to eq "Test description"
      expect( admin.tiers.last.amount_cents ).to eq 1000000
      expect( admin.tiers.last.amount.currency.iso_code ).to eq 'BTC'
    end

    it "should have Settings when created, with nil parameters" do
      admin = Admin.create(
        email: Faker::Internet.email,
        password: Faker::Internet.password
      )
      expect( admin.setting ).not_to be_nil
      expect( admin.setting.profile_pic ).to include '/assets/defaultProfilePic'
      expect( admin.setting.currency ).to eq "USD"
    end
  end
end
