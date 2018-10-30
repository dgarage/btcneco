require 'rails_helper'

RSpec.describe Setting, type: :model do
  context "Properties" do
    it "has the basic properties" do
      settings = Setting.create(
        admin_id: 1,
        name: Faker::Name.name,
        profile_pic: '/assets/xxxxx.jpg',
        tagline: 'XXXXX is building things.',
        main_info: '<p>TEST TEST TEST TEST</p>',
        btcpayserver_keypair: 'e52XXXX',
        btcpayserver_url: 'https://yourbtcserver.com/',
        btcpayserver_token: '2iRqwWt778wsv3ZGghbNAGLykVZMrDtjbixxxxxxxxxx',
        btcpayserver_pem: '-----BEGIN EC PRIVATE KEY-----\nXXXXXXXXXX==\n-----END EC PRIVATE KEY-----\n',
        currency: 'USD'
      )
      expect( settings ).not_to be_nil
      expect( settings.admin_id ).to eq 1
      expect( settings.name ).not_to be_nil
      expect( settings.profile_pic ).to eq '/assets/xxxxx.jpg'
      expect( settings.tagline ).to eq 'XXXXX is building things.'
      expect( settings.main_info ).to eq '<p>TEST TEST TEST TEST</p>'
      expect( settings.btcpayserver_keypair ).to eq 'e52XXXX'
      expect( settings.btcpayserver_url ).to eq 'https://yourbtcserver.com/'
      expect( settings.btcpayserver_token ).to eq '2iRqwWt778wsv3ZGghbNAGLykVZMrDtjbixxxxxxxxxx'
      expect( settings.btcpayserver_pem ).to eq '-----BEGIN EC PRIVATE KEY-----\nXXXXXXXXXX==\n-----END EC PRIVATE KEY-----\n'
      expect( settings.currency ).to eq 'USD'
    end
  end
end
