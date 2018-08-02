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

  context 'validation' do
    subject(:user) { create(:user) }

    it 'should have non empty name' do
      user.name = '   '
      expect(user.valid?).to eq(false)
      expect(user.name).to eq('')

      user.name = '  hello  '
      expect(user.valid?).to eq(true)
      expect(user.name).to eq('hello')
    end

    it 'should have valid email' do
      user.email = 'something@mail.com'
      expect(user.valid?).to eq(true)

      user.email = 'something'
      expect(user.valid?).to eq(false)
    end
  end
end
