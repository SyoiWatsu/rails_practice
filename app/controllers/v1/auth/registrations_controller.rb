class V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController #devise_token_auth gemであらかじめ用意されている認証用のコントローラーを、作成したregistrations_controllerに継承
  private
      def sign_up_params
        params.permit(:name, :email, :password, :password_confirmation)
      end

      def account_update_params
        params.permit(:name, :email)
      end
end
