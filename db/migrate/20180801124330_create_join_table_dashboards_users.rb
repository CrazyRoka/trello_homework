class CreateJoinTableDashboardsUsers < ActiveRecord::Migration[5.2]
  def change
    create_join_table :dashboards, :users do |t|
      # t.index [:dashboard_id, :user_id]
      # t.index [:user_id, :dashboard_id]
    end
  end
end
