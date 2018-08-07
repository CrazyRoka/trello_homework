class List < ApplicationRecord
  extend Title

  squishes :title

  belongs_to :dashboard, touch: true
  has_many :cards, dependent: :destroy
end
