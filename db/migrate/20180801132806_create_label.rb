class CreateLabel < ActiveRecord::Migration[5.2]
  def change
    create_table :labels do |t|
      t.string :name
      t.column :color, :integer, default: 0
      t.belongs_to :dashboard, foreign_key: true
    end
  end
end
