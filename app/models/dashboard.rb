class Dashboard < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :owner, class_name: 'User', required: true
  has_many :lists
  has_many :labels

  validates :title, length: { in: 5..30 }
end
