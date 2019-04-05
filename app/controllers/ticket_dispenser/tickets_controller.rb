# frozen_string_literal: true

module TicketDispenser
  class TicketsController < ApplicationController
    def index
      render json: Ticket.all.includes(:project, :owner, messages: :sender), status: :ok
    end

    def show
      render json: Ticket.where(id: ticket_params[:id])
                         .includes(:project, :owner, messages: :sender).first,
             status: :ok
    end

    def update
      message = Message.create(message_params)
      message.ticket.update!(status: ticket_params[:status])
      render json: message.to_json, status: :created
    end

    def open_tickets
      render json: { open_tickets: Ticket.exists?(status: Ticket::Statuses::OPEN) }
    end

    def read_all_messages
      ticket = Ticket.find(ticket_params[:ticket_id])
      Message.where(ticket: ticket).update_all(read: true)
      render json: { success: true }, status: :ok
    end

    private

    def ticket_params
      params.permit(:id, :status, :project, :alert, :user, :ticket_id)
    end

    def message_params
      params.permit(:content, :kind, :ticket_id, :sender_id, :read, :message)
    end
  end
end
