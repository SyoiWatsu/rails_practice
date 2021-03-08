class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
          # :confirmable

  include DeviseTokenAuth::Concerns::User

  has_many :plans
  has_many :visit_applications
  has_many :plans, through: :visit_applications
end
