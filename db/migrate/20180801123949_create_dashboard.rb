class CreateDashboard < ActiveRecord::Migration[5.2]
  def change
    create_table :dashboards do |t|
      t.string :title
      t.boolean :public
      t.references :owner, references: :user, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
