class User < ApplicationRecord
  has_and_belongs_to_many :dashboards
  has_and_belongs_to_many :cards
  has_many :created_dashboards, class_name:  'Dashboard',
                                foreign_key: 'owner_id',
                                dependent:   :nullify

  validates :name, :email, :password_digest, presence: true, allow_blank: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
