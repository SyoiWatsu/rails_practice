class V1::VisitApplicationsController < ApplicationController

  before_action :authenticate_user!, only: [:create]

  def create
    p "here!!!!!!!!!!!"

    # ①Vueからjson受け取る & データ準備
    authorizer_id = params[:authorizer_id] #被申込者のuser_id
    plan_id = params[:plan_id]
    applicant_id = current_user.id #プラン申込者のuser_id 
    status = "wating"

    # ②受け取った値を元にVisit_applicationのインスタンス作成
    new_visit_application = VisitApplication.new()
    new_visit_application.applicant_id = applicant_id
    new_visit_application.authorizer_id = authorizer_id
    new_visit_application.plan_id = plan_id
    new_visit_application.status = status

    # ③保存
    if new_visit_application.save

      obj = {
        msg: "success !!",
        new_visit_application: {
          applicant_id: applicant_id,
          authorizer_id: authorizer_id,
          plan_id: plan_id,
          status: status,
        },
      }

      render(json: obj, status: 200)
    else
      render({msg: "failed ..."}, status: 500)
    end

  end
end
