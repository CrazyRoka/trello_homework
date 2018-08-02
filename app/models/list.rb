class List < ApplicationRecord
  include Title

  belongs_to :dashboard, touch: true
  has_many :cards
end
