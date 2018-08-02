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

    it 'should have many labels' do
      expect { card.labels.build }.not_to raise_error
    end
  end

  context 'validation' do
    subject(:card) { create(:card) }

    it 'should have non empty title' do
      card.title = 'true'
      expect(card.valid?).to eq(true)

      card.title = ''
      expect(card.valid?).to eq(false)

      card.title = '      '
      expect(card.valid?).to eq(false)
    end

    it 'can have text' do
      card.text = '   '
      expect(card.valid?).to eq(true)
      expect(card.text).to eq('')
    end

    it 'can have due date' do
      card.due_date = nil
      expect(card.valid?).to eq(true)
    end
  end
end
