require 'rails_helper'

describe Comment do
  context 'relationship' do
    subject(:comment) { described_class.new }

    it 'should belongs to owner' do
      expect { comment.owner = User.new }.not_to raise_error
    end

    it 'should belongs to card' do
      expect { comment.card = Card.new }.not_to raise_error
    end

    it 'should have one attachment' do
      expect { comment.attachment = Attachment.new }.not_to raise_error
    end
  end

  context 'validation do' do
    subject(:comment) { create(:comment) }

    it 'must refers to card' do
      comment.card = nil
      expect(comment.valid?).to eq(false)
    end

    it 'must have owner' do
      comment.owner = nil
      expect(comment.valid?).to eq(false)
    end

    it 'can have text' do
      comment.text = '    '
      expect(comment.valid?).to eq(true)
      expect(comment.text).to eq('')
    end

    it 'can have attachment' do
      comment.attachment = nil
      expect(comment.valid?).to eq(true)
    end
  end
end
