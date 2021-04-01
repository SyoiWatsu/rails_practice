class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
          # :confirmable

  include DeviseTokenAuth::Concerns::User

  has_many :plans
  has_many :receive_visit_applications, class_name: 'VisitApplication', foreign_key: :authorizer_id
  has_many :send_visit_applications, class_name: 'VisitApplication', foreign_key: :applicant_id
  has_many :plans, through: :visit_applications

end
