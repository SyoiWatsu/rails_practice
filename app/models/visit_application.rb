class VisitApplication < ApplicationRecord
  belongs_to :user
  belongs_to :plan
end

# ・誰が
# ・どのプランに申し込んで
# ・その承認状況はどうなのか
# を管理するテーブル。