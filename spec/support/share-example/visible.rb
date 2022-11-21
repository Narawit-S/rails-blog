# frozen_string_literal: true
require 'rails_helper'

shared_examples 'Visible' do
  describe 'constant' do
    subject { described_class::VALID_STATUS }

    it { is_expected.to eq %w[published privated archived]}
  end

  describe 'validate' do
    subject { create(described_class.to_s.underscore.to_sym) }

    it { is_expected.to validate_inclusion_of(:status).in_array described_class::VALID_STATUS}
  end

  describe 'public_count' do
    subject { described_class::public_count }

    it { is_expected.to be >= 0 }
  end

  describe 'archived' do
    subject { create(described_class.to_s.underscore.to_sym) }

    it 'result' do
      expect(subject.archived?).to be_in([true, false])
    end
  end

end
