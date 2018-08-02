class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :dashboards
  has_and_belongs_to_many :cards
  has_many :created_dashboards, class_name:  'Dashboard',
                                foreign_key: 'owner_id',
                                dependent:   :nullify

  validates :name, presence: true, allow_blank: false
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_validation { name.strip! }
end
