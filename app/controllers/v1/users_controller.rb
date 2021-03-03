class V1::UsersController < ApplicationController

  # 参照 → https://dev.m6a.jp/entry/2018/11/14/162259
  # これdevise_auth_token使っていない前提のやり方だからだめじゃん。
  # 多分これはイケてない。

  skip_before_action :authenticate!, only: [ :create, :sign_in ]

  def create
    user = User.new(email: params[:email], password: params[:password], name: params[:name])

    if user.save
      render json: user
    else
      render json: { errors: user.errors.full_messages }, status: 400
    end
  end

  def sign_in
  end
end
