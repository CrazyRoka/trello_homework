require 'rails_helper'

describe Dashboard do
  context 'Association' do
    it { is_expected.to have_and_belong_to_many(:users) }
    it { is_expected.to have_many(:lists).dependent(:destroy) }
    it { is_expected.to have_many(:labels).dependent(:destroy) }
    it { is_expected.to belong_to(:owner) }
  end

  context 'Validation' do
    it { is_expected.to validate_presence_of(:title) }
  end

  context 'Callbacks' do
    let(:dashboard) { create(:dashboard, title: '   My  name  ') }

    it 'squishes title' do
      expect(dashboard.title).to eq('My name')
    end
  end

  context 'Scopes' do
    let!(:school_dashboard) { create(:dashboard, title: 'school', owner: owner) }
    let!(:link_up_dashboard) { create(:dashboard, title: 'LinkUp', owner: owner) }
    let(:dashboard_list) { Dashboard.ordered_by_title }
    let(:owner) { create(:user) }

    it 'orders dashboards by title' do
      expect(dashboard_list[0]).to eq(link_up_dashboard)
      expect(dashboard_list[1]).to eq(school_dashboard)
    end
  end
end
