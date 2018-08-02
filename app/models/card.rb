class Card < ApplicationRecord
  include Title

  belongs_to :list, required: true
  has_many :comments, dependent: :destroy
  has_many :attachments, as: :attachable
  has_and_belongs_to_many :labels
  has_and_belongs_to_many :users

  before_validation { text&.strip! }

  scope :by_labels, ->(*label_ids) { joins(:labels)
                                     .where(labels: { color: label_ids }) }
  scope :by_assigned_users, -> (*user_ids) { joins(:users)
                                             .where(users: { id: user_ids }) }
  scope :should_be_done_until, ->(datetime) { where(arel_table[:due_date]
                                                    .lt(datetime)) }
  scope :without_due_date, -> { where(due_date: nil) }
  scope :overdue, -> { where(arel_table[:due_date].lt(Time.now)) }
  scope :by_title, ->(str) { where(arel_table[:title].matches("%#{str}%")) }
end
