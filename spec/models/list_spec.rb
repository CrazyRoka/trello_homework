require 'rails_helper'

describe List do
  context 'Association' do
    it { is_expected.to belong_to(:dashboard).touch(true) }
    it { is_expected.to have_many(:cards).dependent(:destroy) }
  end

  context 'Validation' do
    it { is_expected.to validate_presence_of(:title) }
  end

  context 'Callbacks' do
    let(:list) { create(:list, title: '   My  name  ') }

    it 'squishes title' do
      expect(list.title).to eq('My name')
    end
  end
end
