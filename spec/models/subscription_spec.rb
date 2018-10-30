require 'rails_helper'

RSpec.describe Subscription, type: :model do
  context "Properties" do
    it "has the basic properties" do
      subscription = Subscription.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        last_payment_date: Time.now,
        last_email_reminder: Time.now,
        status: 'new',
        amount_cents: 200000,
        invoice_id: 1,
        invoice_status: 'new',
        tier_id: 1,
        invoice_url: Faker::Internet.url,
        uuid: "xxxxxx"
      )
      expect( subscription ).not_to be_nil
    end
  end
end
