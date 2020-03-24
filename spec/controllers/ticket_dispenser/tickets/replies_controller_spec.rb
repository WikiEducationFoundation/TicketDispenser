# frozen_string_literal: true

require 'rails_helper'

describe TicketDispenser::Tickets::RepliesController, type: :request do
  describe '#destroy' do
    let!(:message) { create(:message) }
    it 'should delete the specified note' do
      expect(TicketDispenser::Message.count).to eq(1)
      delete "/tickets/replies/#{message.id}"
      message_response = JSON.parse(response.body).with_indifferent_access
      expect(message_response[:id]).to eq(message.id)
      expect(TicketDispenser::Message.count).to eq(0)
     end      
  end
end      
