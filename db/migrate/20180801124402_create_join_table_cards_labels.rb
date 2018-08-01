class CreateJoinTableCardsLabels < ActiveRecord::Migration[5.2]
  def change
    create_join_table :cards, :labels do |t|
      # t.index [:card_id, :label_id]
      # t.index [:label_id, :card_id]
    end
  end
end
