require 'rails_helper'

describe Comment do
  context 'Association' do
    it { is_expected.to belong_to(:owner).required }
    it { is_expected.to belong_to(:card).required.counter_cache(true) }
    it { is_expected.to have_one(:attachment).dependent(:destroy) }
  end

  context 'Validation' do
    it { is_expected.not_to validate_presence_of(:text) }
    it { is_expected.not_to validate_presence_of(:attachment) }

    let(:comment) { create(:comment, text: 'smth', attachment: Attachment.create) }
    it 'should have either text or attachment' do
      comment.text = nil
      expect(comment.valid?).to eq(true)

      comment.attachment = nil
      comment.text = 'smth'
      expect(comment.valid?).to eq(true)

      comment.text = nil
      expect(comment.valid?).to eq(false)
    end
  end
end
