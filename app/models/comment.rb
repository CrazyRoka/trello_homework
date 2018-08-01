class Comment < ApplicationRecord
  belongs_to :card
  has_one :attachment, as: :attachable
end
