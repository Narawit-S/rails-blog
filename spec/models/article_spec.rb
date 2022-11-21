# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  body       :text
#  status     :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Article, type: :model do
  include_examples 'Visible'

  describe 'valid factory' do
    describe ':article' do
      subject(:factory) { build(:article) }

      it 'valid' do
        expect(factory).to be_valid
      end
    end
  end

  describe 'assosiation' do
    subject(:article) { create(:article) }

    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end

  describe 'validate' do
    subject(:article) { create(:article) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_least(10) }
  end
end
