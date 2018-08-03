require 'rails_helper'

describe Label do
  context 'Association' do
    it { is_expected.to belong_to(:dashboard) }
    it { is_expected.to have_and_belong_to_many(:cards) }
  end

  context 'Validation' do
    it { is_expected.not_to validate_presence_of(:name) }
  end
end
