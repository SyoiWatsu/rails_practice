class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception # CSRFチェック対策(？)らしい

  skip_before_action :verify_authenticity_token, if: :devise_controller? # APIではCSRFチェックをしない


  layout 'application'
  def index
    render template: :root
  end
end
