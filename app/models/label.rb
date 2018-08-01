class Label < ApplicationRecord
  belongs_to :dashboard
  has_and_belongs_to_many :cards

  enum color: [green: 0, yellow: 1, blue: 2, red: 3, purple: 4]
end
