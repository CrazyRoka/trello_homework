require 'rails_helper'

describe Dashboard do
  context 'relationship' do
    subject(:dashboard) { described_class.new }

    it 'should have many users' do
      expect { dashboard.users.build }.not_to raise_error
    end

    it 'should have many lists' do
      expect { dashboard.lists.build }.not_to raise_error
    end

    it 'should have many labels' do
      expect { dashboard.labels.build }.not_to raise_error
    end

    it 'should belongs to owner' do
      expect { dashboard.owner = User.new }.not_to raise_error
    end
  end
end
