class RenameUserIdColumnToVisitApplications < ActiveRecord::Migration[5.0]
  def change
    rename_column :visit_applications, :user_id, :applicant_id
  end
end
