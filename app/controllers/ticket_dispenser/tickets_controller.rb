# frozen_string_literal: true

module TicketDispenser
  class TicketsController < ApplicationController
    def index
      render json: Ticket.all, status: :ok
    end

    private

    def ticket_params
      params.permit(:status, :course, :alert, :user)
    end
  end
end
