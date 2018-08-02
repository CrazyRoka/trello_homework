class Comment < ApplicationRecord
  belongs_to :card
  belongs_to :owner, class_name: 'User'
  has_one :attachment, as: :attachable

  validate :has_content

  before_validation { text&.strip! }

  private

  def has_content
    if !text && !attachment
      errors.add(context: 'should have text or attachment inside')
    end
  end
end
