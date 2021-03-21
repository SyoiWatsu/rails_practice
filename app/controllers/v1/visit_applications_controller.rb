class V1::VisitApplicationsController < ApplicationController

  before_action :authenticate_user!, only: [:create, :get_notifications]

  def create

    # ①Vueからjson受け取る & データ準備
    authorizer_id = params[:authorizer_id] #被申込者のuser_id
    plan_id = params[:plan_id]
    applicant_id = current_user.id #プラン申込者のuser_id 
    status = "wating"

    # 既に申込済みかどうかを確認
    have_already_applied = VisitApplication.find_by(plan_id: plan_id, applicant_id: applicant_id)

    p have_already_applied.present?

    if have_already_applied.present?
      # render({msg: "you have already applied ..."}, status: 500)
      # ↑ これ返したいけど、この1行でエラー出てる。なんで...？
    else
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
        render(json: {msg: "failed ..."}, status: 500)
      end
    end
  end

  def update_status
    # Vueから値受け取り
    # visit_application_id = params[:visit_application_id]
    # status = params[:status] 

    visit_application_id = 9 # 仮置き
    status = "accepted" # 仮置き

    # idでvisit_applicationsテーブルを検索
    visit_application = VisitApplication.find(visit_application_id)
    p visit_application

    # statusカラムの値を変更
    visit_application.status = status
    p visit_application

    # save
    if visit_application.save
      render(json: {msg: "Status update completed !"}, status: 200)
    else
      render(json: {msg: "failed ..."}, status: 500)
    end

  end

  def get_notifications

    # 表示対象となるauthorizer_idを指定 (現在ログイン中のユーザー)
    authorizer_id = current_user.id

    # 被申し込み一覧を取得
    requests = VisitApplication.where(authorizer_id: authorizer_id)

    notificatoins = []
    requests.each_with_index{ |request, index|

      plan = Plan.find(request.plan_id)
      applicant = User.find(request.applicant_id)
      
      obj = {
        request: request,
        plan: plan,
        applicant: applicant,
      }

      notificatoins.push(obj)
    }

    if notificatoins.present?
      obj = {
        msg: "success !!",
        notificatoins: notificatoins,
      }

      render(json: obj, status: 200)
    else
      render(json: {msg: "failed ..."}, status: 500)
    end
  end
end
