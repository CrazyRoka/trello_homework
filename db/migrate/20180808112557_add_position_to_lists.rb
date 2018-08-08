class AddPositionToLists < ActiveRecord::Migration[5.2]
  def change
    add_column :lists, :position, :decimal, null: false, default: 0

    dashboards = Dashboard.includes(:lists).all
    dashboards.each do |dashboard|
      dashboard.lists.each.with_index do |list, position|
        list.position = 1 << (16 + position)
        list.save
      end
    end
  end
end
