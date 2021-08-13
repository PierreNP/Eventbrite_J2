class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    

    if !current_user.is_admin?
      @user = current_user
      @user_events = Event.where(admin_id:@user.id)
    else 
      @user = User.find(params[:id])
      @user_events = Event.where(admin_id:@user.id)
    end


    
  end


end