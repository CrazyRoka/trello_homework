require 'rails_helper'

describe Card do
  context 'relationship' do
    subject(:card) { described_class.new }

    it 'should have many users' do
      expect { card.users.build }.not_to raise_error
    end

    it 'should have many comments' do
      expect { card.comments.build }.not_to raise_error
    end

    it 'should have many attachments' do
      expect { card.attachments.build }.not_to raise_error
    end

    it 'should have many labels' do
      expect { card.labels.build }.not_to raise_error
    end
  end

  context 'validation' do
    subject(:card) { create(:card) }

    it 'should have non empty title' do
      card.title = 'true'
      expect(card.valid?).to eq(true)

      card.title = ''
      expect(card.valid?).to eq(false)

      card.title = '      '
      expect(card.valid?).to eq(false)
    end

    it 'can have text' do
      card.text = '   '
      expect(card.valid?).to eq(true)
      expect(card.text).to eq('')
    end

    it 'can have due date' do
      card.due_date = nil
      expect(card.valid?).to eq(true)
    end
  end

  context 'scopes' do
    subject!(:homework_card) { create(:card, title: 'Homework') }
    subject!(:something_card) { create(:card, title: 'smth', list: homework_card.list) }

    let(:red) { create(:label, color: :red) }
    let(:yellow) { create(:label, color: :yellow) }

    it 'should return all cards with red label' do
      red.cards << something_card
      red.save!

      yellow.cards << homework_card
      yellow.save!

      expect(Card.by_labels(red.color)).to contain_exactly(something_card)
      expect(Card.by_labels(red.color, yellow.color)).to contain_exactly(something_card, homework_card)
    end

    let(:fred) { create(:user, email: 'fred@email.com') }
    let(:john) { create(:user, email: 'john@email.com') }

    it 'should return cards by assigned users' do
      homework_card.users << fred
      homework_card.save

      something_card.users << john
      something_card.save

      expect(Card.by_assigned_users(fred.id)).to contain_exactly(homework_card)
      expect(Card.by_assigned_users(john.id, fred.id)).to contain_exactly(homework_card, something_card)
    end

    it 'should return cards by matching title' do
      expect(Card.by_title('m')).to contain_exactly(homework_card, something_card)
      expect(Card.by_title('o')).to contain_exactly(homework_card)
    end

    it 'should return cards that should be completed before datetime' do
      homework_card.due_date = 5.days.from_now
      homework_card.save
      expect(Card.should_be_done_until(2.days.from_now)).to contain_exactly()
      expect(Card.should_be_done_until(6.days.from_now)).to contain_exactly(homework_card)
    end

    it 'should return ovedue cards' do
      homework_card.due_date = 5.days.ago
      homework_card.save
      expect(Card.overdue).to contain_exactly(homework_card)
    end

    it 'should return cards without due date' do
      homework_card.due_date = 5.days.ago
      homework_card.save
      expect(Card.without_due_date).to contain_exactly(something_card)
    end
  end
end
