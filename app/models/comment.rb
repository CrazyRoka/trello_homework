class Comment < ApplicationRecord
  belongs_to :card, counter_cache: true
  belongs_to :owner, class_name: 'User', required: true
  has_one :attachment, as: :attachable, dependent: :destroy

  validate :has_content

  before_validation { text&.strip! }

  private

  def has_content
    return if text || attachment
    errors.add(:comment, message: 'should have text or attachment inside')
  end
end
