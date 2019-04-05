# frozen_string_literal: true

module TicketDispenser
  class Tickets::RepliesController < ApplicationController
    def create
      message = Message.create(message_params)
      message.ticket.update!(status: ticket_params[:status])
      render json: message.to_json, status: :created
    end

    private

    def ticket_params
      params.permit(:status)
    end

    def message_params
      params.permit(:content, :kind, :ticket_id, :sender_id, :read, :message)
    end
  end
end
