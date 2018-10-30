require 'rails_helper'

RSpec.describe Goal, type: :model do
  context "Properties" do
    it "has the basic properties" do
      goal = Goal.create(
        admin_id: 1,
        description: "Test description",
        satoshi_amount: 100,
        currency: 'USD'
        #smallest_unit_amount: 1000
      )
      expect( goal ).not_to be_nil
      expect( goal.admin_id ).to eq 1
      expect( goal.description ).to eq "Test description"
      expect( goal.satoshi_amount ).to eq 100
      expect( goal.currency ).to eq 'USD'
      #expect( goal.smallest_unit_amount ).to eq 1000
    end
  end
end
