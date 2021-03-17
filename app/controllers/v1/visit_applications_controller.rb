class V1::VisitApplicationsController < ApplicationController

  before_action :authenticate_user!, only: [:create]

  def create
    p "here!!!!!!!!!!!"

    # ①Vueからjson受け取る
    # ②jsonパース
    applicant_id = 9999 #プラン申込者のuser_id 
    suthorizer_id = 9998 #被申込者のuser_id
    plan_id = 9999
    status = "wating"

    # ↑ まずvisit_applicationsテーブルのカラム変えないといけない。
    # → 再度マイグレーションするマン

    # ③受け取った値を元にVisit_applicationのインスタンス作成
    new_visit_application = Visit_application.new()

    # ④保存

  end
end
