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
    subject { described_class.public_count }

    let(:record) { described_class.to_s.underscore.to_sym }
    let(:published_number) { 4 }

    before do
      create_list(record, published_number, status: 'published')
      create_list(record, 2, status: 'archived')
    end

    context 'is positive number' do
      it { is_expected.to be >= 0}
    end

    context 'is correct number' do
      it { is_expected.to eq published_number}
    end
  end

  describe 'archived' do
    subject { record.archived? }

    let(:record) { create(described_class.to_s.underscore.to_sym) }

    context 'when archived' do
      before do
        record.update(status: 'archived')
      end

      it { is_expected.to eq true }
    end

    context 'when not archived' do
      context 'but published' do
        before do
          record.update(status: 'published')
        end

        it { is_expected.to eq false }
      end

      context 'but privated' do
        before do
          record.update(status: 'privated')
        end

        it { is_expected.to eq false }
      end
    end
  end

end
