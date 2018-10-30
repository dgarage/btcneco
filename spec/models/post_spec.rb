require 'rails_helper'

RSpec.describe Post, type: :model do
  context "Properties" do
    it "has the basic properties" do
      post = Post.create!(
        tier_id: 1,
        content: "Test content",
        title: "Test Title"
      )
      expect( post ).not_to be_nil
    end
  end
end
