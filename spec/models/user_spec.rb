require 'rails_helper'

describe User do
  context 'Association' do
    it { is_expected.to have_and_belong_to_many(:dashboards) }
    it { is_expected.to have_and_belong_to_many(:cards) }
    it { is_expected.to have_many(:created_dashboards).dependent(:nullify) }
  end

  context 'Validation' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to allow_value('email@addresse.foo').for(:email) }
    it { is_expected.not_to allow_value('foo').for(:email) }
  end

  context 'Callbacks' do
    let(:user) { create(:user, name: '   My  name  ') }

    it 'squishes name' do
      expect(user.name).to eq('My name')
    end
  end

  context 'Scopes' do
    let!(:fred) { create(:user, name: 'Fredius') }
    let!(:john) { create(:user, name: 'Johnius') }

    it 'has scope users by names' do
      expect(User.by_username('ius')).to contain_exactly(john, fred)
      expect(User.by_username('fred')).to contain_exactly(fred)
    end
  end

  context 'Image downloading' do
    subject(:user) { create(:user) }

    it 'saves image' do
      expect { user.image = File.open('spec/files/image.jpg') }.not_to raise_error
      expect { user.save }.not_to raise_error
    end
  end
end
