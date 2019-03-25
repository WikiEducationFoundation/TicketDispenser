# frozen_string_literal: true

FactoryBot.define do
  factory :message, class: TicketDispenser::Message do
    content { '' }
    association :sender, factory: :user
    association :ticket, factory: :ticket
  end
end
