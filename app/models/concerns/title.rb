require 'active_support/concern'

module Title
  def squishes(*fields)
    fields.each do |field|
      class_eval(<<-END
        before_validation { #{field}&.squish! }
        validates :#{field}, presence: true
        END
      )
    end
  end
end
