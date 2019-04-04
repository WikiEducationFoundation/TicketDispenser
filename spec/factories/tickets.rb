# frozen_string_literal: true

FactoryBot.define do
  factory :ticket, class: TicketDispenser::Ticket do
    association :project, factory: :course
    association :owner, factory: :user
  end
end
