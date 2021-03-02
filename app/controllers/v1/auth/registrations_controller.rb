class V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController #devise_token_auth gemであらかじめ用意されている認証用のコントローラーを、作成したregistrations_controllerに継承

  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
