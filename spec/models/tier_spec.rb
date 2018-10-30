require 'rails_helper'

RSpec.describe Tier, type: :model do
  context "Properties" do
    it "has the basic properties" do
      tier = Tier.create(
        admin_id: 1,
        description: "Test description",
        amount_cents: 100
      )
      expect( tier ).not_to be_nil
      expect( tier.admin_id ).to eq 1
      expect( tier.description ).to eq "Test description"
      expect( tier.amount_cents ).to eq 100
    end

    it "Money gem test" do
      admin = Admin.create(
        email: Faker::Internet.email,
        password: Faker::Internet.password
      )

      Money.locale_backend = :i18n

      dollar_tier = Tier.create(
        admin_id: admin.id,
        description: "Test description",
        amount_cents: 1000000
      )
      expect( dollar_tier.amount.class ).to eq Money
      expect( dollar_tier.amount.currency.iso_code ).to eq 'USD'
      expect( dollar_tier.amount.currency.name ).to eq 'United States Dollar'
      expect( dollar_tier.amount.format ).to eq '$10,000.00'

      yen_tier = Tier.create!(
        admin_id: admin.id,
        description: "Test description",
        amount_currency: 'JPY',
        amount_cents: 1000001
      )
      expect( yen_tier.amount.class ).to eq Money
      expect( yen_tier.amount.currency.iso_code ).to eq 'JPY'
      expect( yen_tier.amount.currency.name ).to eq 'Japanese Yen'
      expect( yen_tier.amount.format ).to eq '¥1,000,001'

      btc_tier = Tier.create(
        admin_id: admin.id,
        description: "Test description",
        amount_currency: 'BTC',
        amount_cents: 1000002
      )
      expect( btc_tier.amount.class ).to eq Money
      expect( btc_tier.amount.currency ).to eq 'BTC'
      expect( btc_tier.amount.currency.name ).to eq 'Bitcoin'
      expect( btc_tier.amount.to_s ).to eq '0.01000002'
    end
  end
end
