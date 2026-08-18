# frozen_string_literal: true

module TicketDispenser
  class Tickets::RepliesController < ApplicationController
    def create
      message = Message.create(message_params.except(:details))
      message.ticket.update!(status: ticket_params[:status])

      # `to_h` on ActionController::Parameters yields a HashWithIndifferentAccess,
      # which the YAML-serialized `details` column cannot dump under safe_dump.
      # `deep_symbolize_keys` converts it to a plain, symbol-keyed Hash, matching
      # how `details` is written everywhere else.
      details = message_params['details'].to_h.deep_symbolize_keys
      message.update(details: details)

      render json: message.to_json, status: :created
    end

    def destroy
      message = Message.find(message_params[:id])
      message.destroy
      render json: message, status: :ok
    end

    private

    def ticket_params
      params.permit(:status)
    end

    def message_params
      params.permit(:id, :content, :kind, :ticket_id, :sender_id, :read, :message,
                    details: [cc: [:email]])
    end
  end
end
