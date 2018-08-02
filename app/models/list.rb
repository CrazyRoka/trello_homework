class List < ApplicationRecord
  include Title

  belongs_to :dashboard
  has_many :cards
end
