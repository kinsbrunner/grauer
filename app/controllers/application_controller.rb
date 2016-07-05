class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def render_not_found(status = :not_found)
    render text: "#{status.to_s.titleize} :(", status: status
  end
  
  helper_method :current_school
  def current_school
    @current_school ||= School.find_by_id(params[:school_id])
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:lastname])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])    
    devise_parameter_sanitizer.permit(:account_update, keys: [:firstname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:lastname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email])
  end
end