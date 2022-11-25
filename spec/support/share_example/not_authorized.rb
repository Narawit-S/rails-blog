# frozen_string_literal: true

require 'rails_helper'

shared_examples 'not_authorized' do
  let(:user) { create(:user) }

  context 'when user not login' do
    before { sign_out user }

    it 'return 302' do
      subject
      expect(subject.status).to eq(302)
    end    
  end
end
