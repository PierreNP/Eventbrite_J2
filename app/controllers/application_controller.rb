class ApplicationController < ActionController::Base
  def is_attending?
    if current_user.events.include?(Event.find(params[:event_id]))
      redirect_to root_path
    end
    # foutre un flash
  end

  def is_admin?
    if current_user.is_admin == false
      redirect_to user_path(current_user.id)
    end
    # foutre un flash
  end


end
