class List < ApplicationRecord
  extend Title

  squishes :title

  before_create { self.position = dashboard&.lists&.last&.position&.*(2) || (1 << 16) }

  belongs_to :dashboard, touch: true
  has_many :cards, -> { order(:position) }, dependent: :destroy

  validates_numericality_of :position, greater_than_or_equal_to: 0
end
