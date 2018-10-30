require 'rails_helper'

RSpec.describe Invoice, type: :model do
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
      invoice = Invoice.create!(
        invoice_url: "http://testtest",
        invoice_status: "new",
        invoiceTime: Time.now,
        expirationTime: Time.now + 15.minutes,
        amount_cents: 10000,
        tier_id: 1,
        order_id: 1,
        subscription_id: subscription.id
      )
      expect( invoice ).not_to be_nil
    end
  end
end
