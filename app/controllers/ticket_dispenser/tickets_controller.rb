# frozen_string_literal: true

module TicketDispenser
  class TicketsController < ApplicationController
    def index
      tickets = Ticket.where('status != ?', Ticket::Statuses::RESOLVED)
      render json: tickets, status: :ok
    end

    def show
      render json: Ticket.find(ticket_params[:id]), status: :ok
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
      params.permit(:id, :status, :course, :alert, :user, :ticket_id)
    end
  end
end
