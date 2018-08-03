class Dashboard < ApplicationRecord
  include Title

  has_and_belongs_to_many :users
  belongs_to :owner, class_name: 'User', required: true
  has_many :lists, dependent: :destroy
  has_many :labels, dependent: :destroy

  scope :ordered_by_title, -> { order(arel_table[:title].lower) }
end
