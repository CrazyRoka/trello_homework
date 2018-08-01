class Card < ApplicationRecord
  belongs_to :list
  has_many :comments
  has_many :attachments, as: :attachable
  has_and_belongs_to_many :users
end
