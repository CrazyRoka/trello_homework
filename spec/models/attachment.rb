require 'rails_helper'

describe Attachment do
  context 'relationship' do
    subject(:attachment) { described_class.new }

    it 'should have one attachable' do
      expect { attachment.attachable = Card.new }.not_to raise_error
      expect { attachment.attachable = Comment.new }.not_to raise_error
    end
  end
end
