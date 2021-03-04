class V1::PlansController < ApplicationController

  before_action :authenticate_user!, only: [:create]

  def create
    # ①Vueからjson受け取り
    json_request = JSON.parse(request.body.read)

    # ②jsonパース
    title = params[:title]
    detail = params[:detail]
    user_id = current_user.id

    # ③受け取った値を元にPlanのインスタンス作成
    newPlan = Plan.new()
    newPlan.title = title
    newPlan.detail = detail
    newPlan.user_id = user_id

    # ④保存
    if newPlan.save
      
      obj = {
        msg: "success !!",
        newPlan: {
          title: title,
          detail: detail,
          uesr_id: user_id,
        },
      }

      render(json: obj, status: 200)
    else
      render({msg: "failed ..."}, status: 500)
    end

  end
end
