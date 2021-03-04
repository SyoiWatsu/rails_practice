class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception # CSRFチェック対策(？)らしい

  before_action :configure_permitted_parameters, if: :devise_controller? 
  # skip_before_action :verify_authenticity_token, if: :devise_controller? # APIではCSRFチェックをしない(?)
  # skip_before_action :verify_authenticity_token

  layout 'application'
  def index
    render template: :root
  end


  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
