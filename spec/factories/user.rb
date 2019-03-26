# frozen_string_literal: true

FactoryBot.define do
  factory :user do
  end

  trait :admin do
    username { 'admin' }
  end
end
