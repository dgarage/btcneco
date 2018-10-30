require 'rails_helper'

RSpec.describe SubscriptionController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Subscription. As you add validations to Subscription, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {{
    name: Faker::Name.name,
    email: Faker::Internet.email,
    last_payment_date: Time.now,
    last_email_reminder: Time.now,
    status: "new",
    amount_cents: 10000,
    invoice_id: 1,
    invoice_status: "new",
    tier_id: 1,
    invoice_url: Faker::Internet.url,
    uuid: "xxxxx"
  }}

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SubscriptionsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      Subscription.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      subscription = Subscription.create! valid_attributes
      get :show, params: {id: subscription.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      subscription = Subscription.create! valid_attributes
      get :edit, params: {id: subscription.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Subscription" do
        expect {
          post :create, params: {subscription: valid_attributes}, session: valid_session
        }.to change(Subscription, :count).by(1)
      end

      it "redirects to the created subscription" do
        post :create, params: {subscription: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Subscription.last)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {{
        status: "complete",
        invoice_status: "complete"
      }}

      it "updates the requested subscription" do
        subscription = Subscription.create! valid_attributes
        put :update, params: {id: subscription.to_param, subscription: new_attributes}, session: valid_session
        subscription.reload
        expect(subscription.status).to eq "complete"
        expect(subscription.invoice_status).to eq "complete"
      end

      it "redirects to the subscription" do
        subscription = Subscription.create! valid_attributes
        put :update, params: {id: subscription.to_param, subscription: valid_attributes}, session: valid_session
        expect(response).to redirect_to(subscription)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested subscription" do
      subscription = Subscription.create! valid_attributes
      expect {
        delete :destroy, params: {id: subscription.to_param}, session: valid_session
      }.to change(Subscription, :count).by(-1)
    end

    it "redirects to the subscriptions list" do
      subscription = Subscription.create! valid_attributes
      delete :destroy, params: {id: subscription.to_param}, session: valid_session
      expect(response).to redirect_to(subscriptions_url)
    end
  end

end
