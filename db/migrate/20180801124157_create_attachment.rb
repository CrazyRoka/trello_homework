class CreateAttachment < ActiveRecord::Migration[5.2]
  def change
    create_table :attachments do |t|
      t.string :text
      t.references :attachable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
