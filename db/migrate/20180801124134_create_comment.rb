class CreateComment < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :text
      t.belongs_to :card, foreign_key: true
      t.references :owner, references: :user, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
