class UserController < ApplicationController
  def index
    @current_user = current_user
    @subscription = Subscription.find(current_user.subscription_id)
    posts = Post.all
    @posts = []
    posts.each do |post|
      if post.tier_id.include? "#{@subscription.tier_id.to_s}:true"
        @posts << post
      end
    end
  end

  # Settings
  def settings
    #user = current_user
  end

  def settings_update
    user = current_user
    #if @user.save
    if @user.update( user_params )
      render action: "settings", notice: 'User settings was updated.'
    else
      render action: "settings", notice: 'User settings was not updated.'
    end
  end

  private

  def user_params
    params.require( :user ).permit( :password )
  end
end
