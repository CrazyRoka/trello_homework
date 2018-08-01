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
end
