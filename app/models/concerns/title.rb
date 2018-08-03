require 'active_support/concern'

module Title
  extend ActiveSupport::Concern

  included do
    before_validation { title&.squish! }
    validates :title, presence: true, allow_blank: false
  end
end
