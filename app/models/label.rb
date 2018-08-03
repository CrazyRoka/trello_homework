class Label < ApplicationRecord
  belongs_to :dashboard
  has_and_belongs_to_many :cards

  enum color: [:green, :yellow, :blue, :red, :purple]
end
