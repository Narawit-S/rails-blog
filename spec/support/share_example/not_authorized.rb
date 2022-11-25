# frozen_string_literal: true

require 'rails_helper'

shared_examples 'not_authorized' do

  it 'return 302' do
    subject
    expect(subject.status).to eq(302)
  end
end
