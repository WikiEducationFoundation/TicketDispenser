# frozen_string_literal: true

require 'rails_helper'

describe TicketDispenser::TicketsController, type: :request do
  let(:admin) { create(:user, :admin) }
  let(:course) { create(:course) }

  describe '#index' do
    let(:user) { create(:user, username: 'MyUsername') }

    it 'should return an empty json response of all tickets' do
      get '/tickets'
      expected = [].to_json
      expect(response.body).to eq(expected)
    end

    it 'should return messages embedded in tickets if there are any' do
      ticket = TicketDispenser::Ticket.create(owner: admin, project: course, status: 0)
      TicketDispenser::Message.create(ticket: ticket, sender: user, content: 'Hello')

      get '/tickets'
      tickets = JSON.parse(response.body)
      expect(tickets.length).to equal(1)

      ticket = tickets.first
      messages = ticket['messages']
      expect(messages.length).to equal(1)

      message = messages.first
      expect(message['sender']['username']).to eq(user.username)
      expect(message['read']).to equal(false)
    end

    it 'should not include tickets created more than 90 days ago by default' do
      ticket = TicketDispenser::Ticket.create(owner: admin, project: course, status: 0, created_at: 120.days.ago)
      TicketDispenser::Message.create(ticket: ticket, sender: user, content: 'Hello')

      get '/tickets'
      tickets = JSON.parse(response.body)
      expect(tickets.length).to equal(0)
    end
  end

  describe '#destroy' do
    let(:ticket) { create(:ticket) }
    let!(:message) { create(:message, ticket: ticket) }

    it 'should delete the specified ticket (and all messages)' do
      expect(TicketDispenser::Ticket.count).to eq(1)
      expect(TicketDispenser::Message.count).to eq(1)

      delete "/tickets/#{ticket.id}"
      ticket_response = JSON.parse(response.body).with_indifferent_access

      expect(ticket_response[:id]).to eq(ticket.id)
      expect(TicketDispenser::Ticket.count).to eq(0)
      expect(TicketDispenser::Message.count).to eq(0)
    end
  end
end
