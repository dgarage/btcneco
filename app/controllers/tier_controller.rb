class TierController < ApplicationController
  before_action :set_tier, only: [:show, :edit, :update, :destroy]
  before_action :set_currencies

  # GET /admin/tiers
  def index
    @tiers = current_admin.tiers
  end

  # GET /admin/tiers/:id
  def show
  end

  # GET /admin/tiers/new
  def new
    @tier = Tier.new( admin_id: current_admin.id )
  end

  # GET /admin/tiers/:id/edit
  def edit
  end

  # POST /admin/tiers
  def create
    @tier = Tier.new( tier_params )
    if @tier.save
      redirect_to @tier, notice: 'Tier was created.'
    else
      render action: "new", notice: 'Tier was not created.'
    end
  end

  # PUT /admin/tiers/:id
  def update
    if @tier.update( tier_params )
      redirect_to @tier, notice: 'Tier was updated.'
    else
      render action: "edit", notice: 'Tier was not updated.'
    end
  end

  # DELETE /admin/tiers/:id
  def destroy
    @tier.destroy
    redirect_to tiers_url, notice: 'Tier was destroyed.'
  end

  private

  def set_tier
    @tier = Tier.find(params[:id])
  end

  def tier_params
    params.require(:tier).permit(:description, :admin_id, :amount_cents, :amount_currency)
  end

  def set_currencies
    @currencies = ['USD', 'JPY', 'BTC']
  end
end
