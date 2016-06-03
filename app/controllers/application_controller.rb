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

  helper_method :current_family
  def current_family
    @current_family ||= Family.find_by_id(params[:id])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up)        << :firstname
    devise_parameter_sanitizer.for(:sign_up)        << :lastname
    devise_parameter_sanitizer.for(:sign_up)        << :email
    devise_parameter_sanitizer.for(:account_update) << :firstname
    devise_parameter_sanitizer.for(:account_update) << :lastname
    devise_parameter_sanitizer.for(:account_update) << :email
  end
end