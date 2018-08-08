require 'rails_helper'

describe Dashboard do
  context 'Association' do
    it { is_expected.to have_and_belong_to_many(:users) }
    it { is_expected.to have_many(:lists).dependent(:destroy).order(:position) }
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

    let(:other_list) { Dashboard.ordered_by_updates }

    it 'orders dashboards by update' do
      link_up_dashboard.title = '123'
      link_up_dashboard.save
      expect(other_list[0]).to eq(link_up_dashboard)
      expect(other_list[1]).to eq(school_dashboard)
    end
  end

  context 'Copy' do
    let(:dashboard) { create(:dashboard) }
    let(:list) { create(:list, dashboard: dashboard) }
    let(:card) { create(:card, list: list) }
    let!(:comment) { create(:comment, card: card) }
    let!(:label) { create(:label, dashboard: dashboard) }

    it 'copies dashboard with dependencies' do
      label.cards << card
      label.save
      dashboard_copy = CopyDashboard.new.call(dashboard).value!
      expect(dashboard_copy).not_to eq(dashboard)
      expect(dashboard_copy.owner).to eq(dashboard.owner)

      expect(dashboard_copy.lists[0]).not_to eq(dashboard.lists[0])
      expect(dashboard_copy.lists[0].title).to eq(dashboard.lists[0].title)

      expect(dashboard_copy.lists[0].cards[0]).not_to eq(dashboard.lists[0].cards[0])
      expect(dashboard_copy.lists[0].cards[0].text).to eq(dashboard.lists[0].cards[0].text)

      expect(dashboard_copy.lists[0].cards[0].comments[0]).not_to eq(dashboard.lists[0].cards[0].comments[0])
      expect(dashboard_copy.lists[0].cards[0].comments[0].text).to eq(dashboard.lists[0].cards[0].comments[0].text)

      expect(dashboard_copy.labels[0].cards[0]).to eq(dashboard_copy.lists[0].cards[0])
    end
  end
end
