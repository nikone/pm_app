class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  respond_to :json

  before_filter :authorize_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def index
    render 'layouts/application'
  end

  private
  def authorize_user!
    # return 401 if user is not authorized and is trying to acces something other than root_path
    return if user_signed_in? or root_path?
    render json: { error: "You need to sign in or sign up before continuing." }, status: :unauthorized
  end

  def root_path?
    params[:controller] == "application" and params[:action] == "index"
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end
end