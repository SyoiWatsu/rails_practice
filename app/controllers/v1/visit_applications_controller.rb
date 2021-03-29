class V1::VisitApplicationsController < ApplicationController

  before_action :authenticate_user!, only: [:create, :get_notifications, :update_status]

  def create

    # ①Vueからjson受け取る & データ準備
    authorizer_id = params[:authorizer_id] #被申込者のuser_id
    plan_id = params[:plan_id]
    applicant_id = current_user.id #プラン申込者のuser_id 
    status = "wating"

    # 既に申込済みかどうかを確認
    has_already_applied = VisitApplication.where(plan_id: plan_id).where(applicant_id: applicant_id).exists?

    if has_already_applied
      # render({msg: "you have already applied ..."}, status: 500)
      # ↑ これ返したいけど、この1行でエラー出てる。なんで...？
    else
      # ②受け取った値を元にVisit_applicationのインスタンス作成
      new_visit_application = VisitApplication.new(
        applicant_id = applicant_id,
        authorizer_id = authorizer_id,
        plan_id = plan_id,
        status = status,
      )
      

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
    visit_application_id = params[:visit_application_id]
    status = params[:status] 

    # idでvisit_applicationsテーブルを検索
    visit_application = VisitApplication.find(visit_application_id)

    # statusカラムの値を変更
    visit_application.status = status

    # save
    if visit_application.save
      render(json: {msg: "Status update completed !"}, status: 200)
    else
      render(json: {msg: "failed ..."}, status: 500)
    end
  end

  def get_notifications

    # 通知するべきデータを全部持つ配列
    notificatoins = [] 

    # === === 自分宛ての申請 === ===
    # 表示対象となるauthorizer_idを指定 (現在ログイン中のユーザー)
    authorizer_id = current_user.id

    # 被申し込み一覧を取得
    # === === === === ===
    # preload ver
    visit_applications_be_applied = VisitApplication.where(authorizer_id: authorizer_id).preload(:user, :plan)
    # eager_load ver
    # visit_applications_be_applied = VisitApplication.where(authorizer_id: authorizer_id).eager_load(:user, :plan)
    # === === === === ===
    # ↑どっちが早いんじゃろうな？
    # joinが違うのは確実。なぜなら『先取りしてキャッシュ』ということはしてくれないから。
    # 参照先のテーブルの値で絞り込みしないからpreloadで良さそうかな？

    if visit_applications_be_applied.present?
      visit_applications_be_applied.each_with_index{ |visit_application, index|

        # === === === === ===
        # Good
        plan = visit_application.plan
        applicant = visit_application.user
        # ↑ belongs_toで紐づけてるから、これで取ってこられる

        # Bad
        # plan = Plan.find(visit_application.plan_id)
        # applicant = User.find(visit_application.applicant_id)
        # === === === === ===
        
        obj = {
          request: visit_application,
          plan: plan,
          applicant: applicant,
          is_applied: true,
        }

        notificatoins.push(obj)
      }
    end
    
    

    # === === 自分がした申請 && 承認された === ===
    applicant_id = current_user.id
    visit_applications_applied = VisitApplication.where(applicant_id: applicant_id).preload(:user, :plan)
    if visit_applications_applied.present?
      visit_applications_applied.each_with_index{ |visit_application, index|

        # statusがacceptedでない場合は処理離脱
        if visit_application[:status] != "accepted" 
          next 
        end

        plan = visit_application.plan
        applicant = visit_application.user
        
        obj = {
          request: visit_application,
          plan: plan,
          planner: applicant,
          is_applied: false,
        }

        notificatoins.push(obj)
      }
    end

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
