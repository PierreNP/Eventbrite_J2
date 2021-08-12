class ApplicationController < ActionController::Base
  def is_attending?
    if current_user.events.include?(Event.find(params[:event_id]))
      redirect_to root_path
    end
    # foutre un flash
  end
end
