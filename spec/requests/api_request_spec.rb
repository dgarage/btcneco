require 'rails_helper'

RSpec.describe "API Request", type: :request do
  context "Notification URL from BTCPayServer" do
    it "should parse notifications from BTCPayServer" do
      notificationSample = {
        "id":"SkdsDghkdP3D3qkj7bLq3",
        "url":"https://btcpay.example.com/invoice?id=SkdsDghkdP3D3qkj7bLq3",
        "status":"paid",
        "price":10,
        "currency":"EUR",
        "invoiceTime":1520373130312,
        "expirationTime":1520374030312,
        "currentTime":1520373179327,
        "exceptionStatus":false,
        "buyerFields":{
          "buyerEmail":"customer@example.com",
          "buyerNotify":false
        },
        "paymentSubtotals": {
          "BTC":114700
        },
        "paymentTotals": {
          "BTC":118400
        },
        "transactionCurrency": "BTC",
        "amountPaid": "1025900",
        "exchangeRates": {
          "BTC": {
            "EUR": 8721.690715789999,
            "USD": 10817.99
          }
        }
      }
      post '/api_notification', params: notificationSample
      expect( response.status ).to eq 204
    end
  end
end
