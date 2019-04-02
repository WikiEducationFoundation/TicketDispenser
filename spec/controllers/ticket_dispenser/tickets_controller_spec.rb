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
      ticket = TicketDispenser::Ticket.create(owner: admin, course: course, status: 0)
      TicketDispenser::Message.create(ticket: ticket, sender: user, content: 'Hello')

      get '/tickets'
      tickets = JSON.parse(response.body)
      expect(tickets.length).to equal(1)

      ticket = tickets.first
      messages = ticket['messages']
      expect(messages.length).to equal(1)

      message = messages.first
      expect(message['sender']).to eq('MyUsername')
      expect(message['read']).to equal(false)
    end
  end
end
