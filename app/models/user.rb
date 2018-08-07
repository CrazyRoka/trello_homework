class User < ApplicationRecord
  include ImageUploader::Attachment.new(:image)

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :dashboards
  has_and_belongs_to_many :cards
  has_many :created_dashboards, class_name:  'Dashboard',
                                foreign_key: 'owner_id',
                                dependent:   :nullify

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_validation { name&.squish! }

  scope :by_username, ->(str) { where(arel_table[:name].matches("%#{str}%")) }
end
