class V1::PlansController < ApplicationController
  def create
    # ①Vueからjson受け取り
    json_request = JSON.parse(request.body.read)

    # ②jsonパース
    title = params[:title]
    detail = params[:detail]

    # ③受け取った値を元にPlanのインスタンス作成
    newPlan = Plan.new()
    newPlan.title = title
    newPlan.detail = detail

    # Planにuser_id紐づけるの、多分こんな感じ
    # newPlan.user_id = current_user().user_id


    # ④保存
    if newPlan.save
      
      obj = {
        msg: "success !!",
        newPlan: {
          title: title,
          detail: detail,
        },
      }

      render(json: obj, status: 200)
    else
      render({msg: "failed ..."}, status: 500)
    end

  end
end
