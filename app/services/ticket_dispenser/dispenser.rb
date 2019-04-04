# frozen_string_literal: true

module TicketDispenser
  class Dispenser
    def self.call(content:, project_id: nil, owner_id:, sender_id: nil)
      ticket = Ticket.new(
        project_id: project_id,
        owner_id: owner_id
      )
      Message.create!(
        content: content,
        sender_id: sender_id,
        ticket: ticket
      )

      return ticket
    end
  end
end
