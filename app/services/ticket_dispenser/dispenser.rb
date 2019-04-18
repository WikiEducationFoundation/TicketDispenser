# frozen_string_literal: true

module TicketDispenser
  class Dispenser
    def self.call(content:, project_id: nil, owner_id:, sender_id: nil, subject: nil, sender_email: nil, details: {})
      ticket = Ticket.new(
        project_id: project_id,
        owner_id: owner_id
      )
      Message.create!(
        content: content,
        sender_id: sender_id,
        ticket: ticket,
        details: { subject: subject, sender_email: sender_email, **details}
      )

      return ticket
    end

    def self.thread(content:, reference_id:, sender_id:, subject: nil, sender_email: nil, details: {})
      ticket = Ticket.where(id: reference_id.to_i).first
      raise unless ticket
      raise unless ticket.in_recipient_list?(sender_id)

      ticket.update(status: Ticket::Statuses::OPEN)
      Message.create!(
        content: content,
        sender_id: sender_id,
        ticket: ticket,
        details: { subject: subject, sender_email: sender_email, **details }
      )
    end
  end
end
