# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TicketDispenser::Dispenser, type: :service do
  let(:owner) { create(:user, :admin) }
  let(:sender) { create(:user) }
  let(:course) { create(:course) }

  describe '#call' do
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

    it 'creates a ticket and an associated message with a subject if provided' do
      ticket = TicketDispenser::Dispenser.call(
        content: 'This is my first message to you',
        project_id: course.id,
        owner_id: owner.id,
        sender_id: sender.id,
        subject: 'My Subject'
      )

      expect(ticket).to be_a(TicketDispenser::Ticket)
      expect(ticket.owner).to eq(owner)
      expect(ticket.messages.length).to eq(1)
      expect(ticket.messages.first.details[:subject]).to eq('My Subject')
    end

    it 'creates a ticket and an associated message with a sender_email if provided' do
      ticket = TicketDispenser::Dispenser.call(
        content: 'This is my first message to you',
        project_id: course.id,
        owner_id: owner.id,
        sender_id: sender.id,
        sender_email: 'sender@email.com'
      )

      expect(ticket).to be_a(TicketDispenser::Ticket)
      expect(ticket.owner).to eq(owner)
      expect(ticket.messages.length).to eq(1)
      expect(ticket.messages.first.details[:sender_email]).to eq('sender@email.com')
    end

    it 'creates a ticket and an associated message with additional details' do
      ticket = TicketDispenser::Dispenser.call(
        content: 'This is my first message to you',
        project_id: course.id,
        owner_id: owner.id,
        sender_id: sender.id,
        details: { cc: [ 'other@email.com' ] }
      )

      expect(ticket).to be_a(TicketDispenser::Ticket)
      expect(ticket.owner).to eq(owner)
      expect(ticket.messages.length).to eq(1)
      expect(ticket.messages.first.details[:cc]).to eq([ 'other@email.com' ])
    end

    it 'creates a ticket and an associated message with many additional details' do
      ticket = TicketDispenser::Dispenser.call(
        content: 'This is my first message to you',
        project_id: course.id,
        owner_id: owner.id,
        sender_id: sender.id,
        sender_email: 'sender@email.com',
        subject: 'My Subject',
        details: { cc: [ 'other@email.com' ] }
      )

      expect(ticket).to be_a(TicketDispenser::Ticket)
      expect(ticket.owner).to eq(owner)
      expect(ticket.messages.length).to eq(1)
      expect(ticket.messages.first.details[:sender_email]).to eq('sender@email.com')
      expect(ticket.messages.first.details[:subject]).to eq('My Subject')
      expect(ticket.messages.first.details[:cc]).to eq([ 'other@email.com' ])
    end
  end

  describe '#thread' do
    it 'adds a new message to the thread based on the reference id' do
      ticket = TicketDispenser::Dispenser.call(
        content: 'This is my first message to you',
        owner_id: owner.id,
        sender_id: sender.id
      )

      TicketDispenser::Dispenser.thread(
        content: 'This is my second message to you',
        reference_id: ticket.reference_id,
        sender_id: sender.id
      )

      expect(ticket.status).to eq(TicketDispenser::Ticket::Statuses::OPEN)
      expect(ticket.messages.length).to eq(2)
    end
  end
end
