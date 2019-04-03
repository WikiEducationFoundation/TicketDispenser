# frozen_string_literal: true

module TicketDispenser
  class MessagesController < ApplicationController
    def create
      message = Message.create(ticket_params)
      render json: message.to_json, status: :created
    end

    private
    
    def ticket_params
      params.permit(:id, :content, :kind, :ticket_id, :sender_id, :read, :message)
    end
  end
end