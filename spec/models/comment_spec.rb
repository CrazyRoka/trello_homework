require 'rails_helper'

describe Comment do
  context 'relationship' do
    subject(:comment) { described_class.new }

    it 'should belongs to card' do
      expect { comment.card = Card.new }.not_to raise_error
    end

    it 'should have one attachment' do
      expect { comment.attachment = Attachment.new }.not_to raise_error
    end
  end
end
