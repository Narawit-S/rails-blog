# frozen_string_literal: true

FactoryBot.define do
    factory :user do
      email { 'test@gmail.com' }
      password { 'thisistestpassword' }
    end
  end
