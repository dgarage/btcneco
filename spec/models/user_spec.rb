require 'rails_helper'

RSpec.describe User, type: :model do
  context "Properties" do
    it "has the basic properties" do
      user = User.create!(
        email: Faker::Internet.email,
        password: Faker::Internet.password
      )
      expect( user ).not_to be_nil
    end
  end
end
