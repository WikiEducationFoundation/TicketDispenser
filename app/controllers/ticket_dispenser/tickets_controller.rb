# frozen_string_literal: true

module TicketDispenser
  class TicketsController < ApplicationController
    def index
      render json: Ticket.all, status: :ok
    end

    def show
      render json: Ticket.find(ticket_params[:id]), status: :ok
    end

    def open_tickets
      render json: { open_tickets: Ticket.exists?(status: Ticket::Statuses::OPEN) }
    end

    private

    def ticket_params
      params.permit(:id, :status, :course, :alert, :user)
    end
  end
end
