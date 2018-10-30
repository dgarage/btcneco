class GoalController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]

  # GET /admin/goals
  def index
    @goals = current_admin.goals
  end

  # GET /admin/goals/:id
  def show
  end

  # GET /admin/goals/new
  def new
    @goal = Goal.new( admin_id: current_admin.id )
  end

  # GET /admin/goals/:id/edit
  def edit
  end

  # POST /admin/goals
  def create
    @goal = Goal.new( goal_params )
    if @goal.save
      redirect_to @goal, notice: 'Goal was created.'
    else
      render action: "new", notice: 'Goal was not created.'
    end
  end

  # PUT /admin/goals/:id
  def update
    if @goal.update( goal_params )
      redirect_to @goal, notice: 'Goal was updated.'
    else
      render action: "edit", notice: 'Goal was not updated.'
    end
  end

  # DELETE /admin/goals/:id
  def destroy
    @goal.destroy
    redirect_to goals_url, notice: 'Goal was destroyed.'
  end

  private

  def set_goal
    @goal = Goal.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(:description, :satoshi_amount, :admin_id)
  end
end
