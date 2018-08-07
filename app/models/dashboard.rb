class Dashboard < ApplicationRecord
  extend Title

  squishes :title

  has_and_belongs_to_many :users
  belongs_to :owner, class_name: 'User', required: true
  has_many :lists, dependent: :destroy
  has_many :labels, dependent: :destroy

  scope :ordered_by_title, -> { order(title: :asc) }
  scope :ordered_by_updates, -> { order(updated_at: :desc) }
end
