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

  def params_user_id
    params[:user_id]
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password, :encrypted_password])
    end

end
