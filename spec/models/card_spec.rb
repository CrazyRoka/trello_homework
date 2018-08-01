require 'rails_helper'

describe Card do
  context 'relationship' do
    subject(:card) { described_class.new }

    it 'should have many users' do
      expect { card.users.build }.not_to raise_error
    end

    it 'should have many comments' do
      expect { card.comments.build }.not_to raise_error
    end

    it 'should have many attachments' do
      expect { card.attachments.build }.not_to raise_error
    end
  end
end
