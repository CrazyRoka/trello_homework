class List < ApplicationRecord
  belongs_to :dashboard
  has_many :cards
end
