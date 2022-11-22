# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  include_examples 'Visible'

  describe 'valid factory' do
    subject { build(:comment) }

    it { is_expected.to be_valid }
  end

  describe 'belong to' do
    subject { create(:comment) }

    it { is_expected.to belong_to(:article) }
  end

  describe 'validate' do
    subject { create(:comment) }

    it { is_expected.to validate_presence_of(:commenter) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_least(10) }
  end
end
