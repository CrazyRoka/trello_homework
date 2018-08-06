require 'rails_helper'

describe Card do
  context 'Association' do
    it { is_expected.to have_and_belong_to_many(:users) }
    it { is_expected.to have_and_belong_to_many(:labels) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:attachments).dependent(:destroy) }
    it { is_expected.to belong_to(:list).touch(true) }
  end

  context 'Validation' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.not_to validate_presence_of(:text) }
    it { is_expected.not_to validate_presence_of(:due_date) }
  end

  context 'Callbacks' do
    let(:card) { create(:card, title: '   My  name  ', text: '  My  name  ') }

    it 'squishes title' do
      expect(card.title).to eq('My name')
    end
  end

  context 'Scopes' do
    let!(:homework_card) { create(:card, title: 'Homework') }
    let!(:something_card) { create(:card, title: 'smth') }

    let(:red) { create(:label, color: :red) }
    let(:yellow) { create(:label, color: :yellow) }

    it 'filters by label' do
      red.cards << something_card
      red.save!

      yellow.cards << homework_card
      yellow.save!

      expect(Card.by_labels(red)).to contain_exactly(something_card)
      expect(Card.by_labels([red, yellow])).to contain_exactly(something_card, homework_card)
    end

    let(:fred) { create(:user, email: 'fred@email.com') }
    let(:john) { create(:user, email: 'john@email.com') }

    it 'filters by assigned users' do
      homework_card.users << fred
      homework_card.save

      something_card.users << john
      something_card.save

      expect(Card.by_assigned_users(fred.id)).to contain_exactly(homework_card)
      expect(Card.by_assigned_users([john.id, fred.id])).to contain_exactly(homework_card, something_card)
    end

    it 'filters by title' do
      expect(Card.by_title('m')).to contain_exactly(homework_card, something_card)
      expect(Card.by_title('o')).to contain_exactly(homework_card)
    end

    it 'filters by overdue in datetime' do
      homework_card.due_date = 5.days.from_now
      homework_card.save
      expect(Card.should_be_done_until(2.days.from_now)).to contain_exactly()
      expect(Card.should_be_done_until(6.days.from_now)).to contain_exactly(homework_card)
    end

    it 'filters by overdue' do
      homework_card.due_date = 5.days.ago
      homework_card.save
      expect(Card.overdue).to contain_exactly(homework_card)
    end

    it 'filters by presence of due date' do
      homework_card.due_date = 5.days.ago
      homework_card.save
      expect(Card.without_due_date).to contain_exactly(something_card)
    end
  end
end
