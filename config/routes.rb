Rails.application.routes.draw do
  # mount_devise_token_auth_for 'User', at: 'auth'

  # === === === Sample === === ===
  root "application#index"
  get "/api/sample", controller: :api, action: :sample
  post "/api/new", controller: :api, action: :create
  get "/api/index", controller: :api, action: :index


  # === === === MatcherClone === === ===
  devise_for :users

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for "User", at: "auth"
    end
  end
  # /api/v1/auth

  post "/api/v1/plans/new", controller: "v1/plans", action: :create
  # 基本的に[app/controllers]直下にある想定で動くみたいなので
  # ネストした場所に当該コントローラーがある場合は場所を教えてあげる必要あり。
  get "/api/v1/plans/:id", controller: "v1/plans", action: :show
  get "api/current-user", controller: "v1/plans", action: :get_current_user

end
