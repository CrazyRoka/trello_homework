class AddPositionToCards < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :position, :decimal, null: false, default: 0

    lists = List.includes(:cards).all
    lists.each do |list|
      list.cards.each.with_index do |card, position|
        card.position = 1 << (16 + position)
        card.save
      end
    end
  end
end
