# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TicketDispenser::Dispenser, type: :service do
  let(:owner) { create(:user, :admin) }
  let(:sender) { create(:user) }
  let(:course) { create(:course) }

  it 'creates a ticket and an associated message' do
    ticket = TicketDispenser::Dispenser.call(
      content: 'This is my first message to you',
      project_id: course.id,
      owner_id: owner.id,
      sender_id: sender.id
    )

    expect(ticket).to be_a(TicketDispenser::Ticket)
    expect(ticket.owner).to eq(owner)
    expect(ticket.messages.length).to eq(1)
  end

  it 'creates a ticket and an associated message even if there is no sender' do
    ticket = TicketDispenser::Dispenser.call(
      content: 'This is my first message to you',
      project_id: course.id,
      owner_id: owner.id
    )

    expect(ticket).to be_a(TicketDispenser::Ticket)
    expect(ticket.owner).to eq(owner)
    expect(ticket.messages.length).to eq(1)
  end

  it 'creates a ticket and an associated message even if there is no course' do
    ticket = TicketDispenser::Dispenser.call(
      content: 'This is my first message to you',
      owner_id: owner.id,
      sender_id: sender.id
    )

    expect(ticket).to be_a(TicketDispenser::Ticket)
    expect(ticket.owner).to eq(owner)
    expect(ticket.messages.length).to eq(1)
  end
end
