require 'rails_helper'

RSpec.describe HomeHelper, type: :helper do
  describe '#convert_satoshi_to_btc' do
    it 'returns btc values for satoshi values' do
      expect( satoshi_to_btc(1) ).to eq "0.00000001"
      expect( satoshi_to_btc(100) ).to eq "0.000001"
      expect( satoshi_to_btc(10000) ).to eq "0.0001"
      expect( satoshi_to_btc(1000000) ).to eq "0.01"
      expect( satoshi_to_btc(100000000) ).to eq "1"
      expect( satoshi_to_btc(10000000000) ).to eq "100"
    end
  end
end
