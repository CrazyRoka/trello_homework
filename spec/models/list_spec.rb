require 'rails_helper'

describe List do
  context 'relationship' do
    subject(:list) { described_class.new }

    it 'should belongs to one dashboard' do
      expect { list.dashboard = Dashboard.new }.not_to raise_error
    end

    it 'should have many cards' do
      expect { list.cards.build }.not_to raise_error
    end
  end

  context 'validation' do
    subject(:list) { create(:list) }

    it 'should have non empty title' do
      list.title = '   '
      expect(list.valid?).to eq(false)

      list.title = '  hello '
      expect(list.valid?).to eq(true)
      expect(list.title).to eq('hello')
    end

    it 'should update dashboard' do
      expect { list.touch }.to change { list.dashboard.updated_at }
    end
  end
end
