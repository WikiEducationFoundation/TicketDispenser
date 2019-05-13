# frozen_string_literal: true

module TicketDispenser
  class TicketsController < ApplicationController
    def index
      query = Ticket.all.includes(:project, :owner, messages: :sender).order(id: :desc)

      offset = ticket_params[:offset] || 0
      limit = ticket_params[:limit] || 100
      query = query.offset(offset).limit(limit)

      render json: query, status: :ok
    end

    def show
      render json: Ticket.where(id: ticket_params[:id])
                         .includes(:project, :owner, messages: :sender).first,
             status: :ok
    end

    def update
      ticket = Ticket.find(ticket_params[:id])
      ticket.update!(ticket_params)
      render json: ticket, status: :ok
    end

    def destroy
      ticket = Ticket.find(ticket_params[:id])
      ticket.destroy
      render json: ticket, status: :ok
    end

    def open_tickets
      conditions = { status: Ticket::Statuses::OPEN }
      # If query is scoped to a specific owner, check for their tickets AND unowned tickets
      conditions[:owner_id] = [open_ticket_params[:owner_id], nil] if open_ticket_params[:owner_id]
      render json: { open_tickets: Ticket.exists?(conditions) }
    end

    def read_all_messages
      Message.where(ticket_id: ticket_params[:ticket_id]).update_all(read: true)
      ticket = Ticket.find(ticket_params[:ticket_id])
      render json: ticket, status: :ok
    end

    private

    def open_ticket_params
      params.permit(:owner_id)
    end

    def ticket_params
      params.permit(:id, :status, :project, :alert, :user, :ticket_id, :owner_id,
                    :limit, :offset)
    end
  end
end
