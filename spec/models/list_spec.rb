require 'rails_helper'

describe List do
  context 'Association' do
    it { is_expected.to belong_to(:dashboard).required.touch(true) }
    it { is_expected.to have_many(:cards).dependent(:destroy).order(:position) }
  end

  context 'Validation' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_numericality_of(:position).is_greater_than_or_equal_to(0) }

  end

  context 'Callbacks' do
    let(:list) { create(:list, title: '   My  name  ') }

    it 'squishes title' do
      expect(list.title).to eq('My name')
    end

    it 'increases position' do
      expect(list.position).to eq(1<<16)
      expect(create(:list, dashboard: list.dashboard).position).to eq(1<<17)
      expect(create(:list).position).to eq(1<<16)
    end
  end
end
