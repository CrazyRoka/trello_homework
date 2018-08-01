class CreateUser < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, index: true, null: false
      t.string :password_digest, null: false
      t.string :avatar

      t.timestamps
    end
  end
end
