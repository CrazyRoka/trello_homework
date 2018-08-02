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

  context 'validation' do
    subject(:dashboard) { create(:dashboard) }

    it 'should have non empty title' do
      dashboard.title = '   '
      expect(dashboard.valid?).to eq(false)
      expect(dashboard.title).to eq('')

      dashboard.title = '  hello  '
      expect(dashboard.valid?).to eq(true)
      expect(dashboard.title).to eq('hello')
    end

    it 'should have owner' do
      dashboard.owner = nil
      expect(dashboard.valid?).to eq(false)
    end
  end

  context 'scopes' do
    let!(:school_dashboard) { create(:dashboard, title: 'school', owner: owner) }
    let!(:link_up_dashboard) { create(:dashboard, title: 'LinkUp', owner: owner) }
    let(:dashboard_list) { Dashboard.ordered_by_title }
    let(:owner) { create(:user) }

    it 'should order dashboards by title' do
      expect(dashboard_list).to contain_exactly(school_dashboard, link_up_dashboard)
    end
  end
end
