class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    @user = current_user

    @user_events = Event.where(admin_id:@user.id)
  end


end
