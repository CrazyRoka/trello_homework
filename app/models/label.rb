class Label < ApplicationRecord
  belongs_to :dashboard

  enum color: [green: 0, yellow: 1, blue: 2, red: 3, purple: 4]
end
