require 'rails_helper'

describe User do
  context 'relationship' do
    subject(:user) { described_class.new }

    it 'should have many dashboards' do
      expect { user.dashboards.build }.not_to raise_error
    end

    it 'should have many created dashboards' do
      expect { user.created_dashboards.build }.not_to raise_error
    end

    it 'should have many cards' do
      expect { user.cards.build }.not_to raise_error
    end
  end
end
