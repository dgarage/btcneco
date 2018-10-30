require 'bitpay_sdk'

module AdminHelper
  def generate_pem
    BitPay::KeyUtils.generate_pem
  end

  def getPairToken( url, token )
    pem = generate_pem
    client = BitPay::SDK::Client.new(api_uri: url, pem: pem)
    result = client.pair_client(pairingCode: token)
    return pem, result
  end

  def getInvoice( price, currency, url, pem )
    client = BitPay::SDK::Client.new(api_uri: url, pem: pem)
    invoice = client.create_invoice(price: price, currency: "USD")
    return invoice
  end
end
