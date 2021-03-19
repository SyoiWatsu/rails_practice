class AddAuthorizerIdToVisitApplications < ActiveRecord::Migration[5.0]
  def change
    add_column :visit_applications, :authorizer_id, :integer
  end
end
