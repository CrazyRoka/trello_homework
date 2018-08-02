class Card < ApplicationRecord
  include Title

  belongs_to :list, required: true
  has_many :comments, dependent: :destroy
  has_many :attachments, as: :attachable
  has_and_belongs_to_many :labels
  has_and_belongs_to_many :users

  before_validation { text&.strip! }
end
