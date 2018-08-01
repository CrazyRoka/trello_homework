class CreateList < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.string :title, null: false
      t.belongs_to :dashboard, foreign_key: true

      t.timestamps
    end
  end
end
