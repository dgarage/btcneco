require 'rails_helper'

RSpec.describe Btcpayserverlog, type: :model do
  context "Properties" do
    it "has the basic properties" do
      log = Btcpayserverlog.create(
        message: "Test test test"
      )
      expect( log ).not_to be_nil
    end
  end
end
