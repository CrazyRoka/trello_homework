class CreateDashboard < ActiveRecord::Migration[5.2]
  def change
    create_table :dashboards do |t|
      t.string :title, null: false
      t.boolean :public, null: false
      t.references :owner, references: :user, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
