class RemoveVisitApplicationIdToVisitApplications < ActiveRecord::Migration[5.0]
  def change
    remove_column :visit_applications, :visit_application_id, :integer
  end
end
