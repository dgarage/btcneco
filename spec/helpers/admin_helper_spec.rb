require 'rails_helper'

RSpec.describe AdminHelper, type: :helper do
  describe '#generate_pem' do
    it 'returns PEM private key' do
      pem = generate_pem
      expect( pem ).not_to be_nil
      expect( pem ).not_to eq ""
      expect( pem ).to include "BEGIN EC PRIVATE KEY"
    end
  end
end
