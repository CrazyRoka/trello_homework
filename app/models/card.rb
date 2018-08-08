class Card < ApplicationRecord
  extend Title

  squishes :title

  belongs_to :list, required: true, touch: true
  has_many :comments, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_and_belongs_to_many :labels
  has_and_belongs_to_many :users

  before_validation { text&.strip! }
  before_create { self.position = list&.cards&.last&.position&.*(2) || (1 << 16) }

  scope :by_labels,
        ->(label_ids) { joins(:labels).where(labels: { id: label_ids }) }
  scope :by_assigned_users,
        ->(user_ids) { joins(:users).where(users: { id: user_ids }) }
  scope :should_be_done_until,
        ->(datetime) { where(arel_table[:due_date].lt(datetime)
                             .and(arel_table[:completed].eq(false)))
                     }
  scope :without_due_date, -> { where(due_date: nil) }
  scope :overdue, -> { should_be_done_until(Time.now) }
  scope :by_title, ->(str) { where(arel_table[:title].matches("%#{str}%")) }

  validates_numericality_of :position, greater_than_or_equal_to: 0
end
