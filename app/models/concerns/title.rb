require 'active_support/concern'

module Title
  extend ActiveSupport::Concern

  included do
    before_validation { title&.strip! }
    validates :title, presence: true, allow_blank: false
  end

  # class_methods do
  # end
end
