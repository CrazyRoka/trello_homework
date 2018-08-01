require 'rails_helper'

describe Label do
  context 'relationship' do
    subject(:label) { described_class.new }

    it 'should belongs to dashboard' do
      expect { label.dashboard = Dashboard.new }.not_to raise_error
    end
  end
end