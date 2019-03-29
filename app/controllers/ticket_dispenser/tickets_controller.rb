# frozen_string_literal: true

module TicketDispenser
  class TicketsController < ApplicationController
    def index
      render json: Ticket.all, status: :ok
    end

    def show
      render json: Ticket.find(ticket_params[:id]), status: :ok
    end

    private

    def ticket_params
      params.permit(:id, :status, :course, :alert, :user)
    end
  end
end
