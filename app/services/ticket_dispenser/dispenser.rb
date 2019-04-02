# frozen_string_literal: true

module TicketDispenser
  class Dispenser
    def self.call(content:, course_id: nil, owner_id:, sender_id: nil)
      ticket = TicketDispenser::Ticket.new(
        course_id: course_id,
        owner_id: owner_id
      )
      TicketDispenser::Message.create!(
        content: content,
        sender_id: sender_id,
        ticket: ticket
      )

      return ticket
    end
  end
end