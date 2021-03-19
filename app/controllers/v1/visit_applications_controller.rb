class V1::VisitApplicationsController < ApplicationController

  before_action :authenticate_user!, only: [:create]

  def create
    p "here!!!!!!!!!!!"

    # ①Vueからjson受け取る & データ準備
    authorizer_id = params[:authorizer_id] #被申込者のuser_id
    plan_id = params[:plan_id]
    applicant_id = current_user.id #プラン申込者のuser_id 
    status = "wating"

    # ↑ まずvisit_applicationsテーブルのカラム変えないといけない。
    # → 再度マイグレーションするマン

    # ②受け取った値を元にVisit_applicationのインスタンス作成
    # new_visit_application = Visit_application.new()

    # ③保存


    
    # memo
    # ①VisitApplicationテーブルの"user_id"カラム名を"applicant_id"に変更
    # ②VisitApplicationテーブルに"authorizer_id"カラムを追加

  end
end
