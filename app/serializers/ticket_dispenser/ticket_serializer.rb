# frozen_string_literal: true

# == Schema Information
#
# Table name: ticket_dispenser_tickets
#
#  id         :bigint(8)        not null, primary key
#  project_id :bigint(8)
#  owner_id   :integer
#  status     :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

module TicketDispenser
  class TicketSerializer < ActiveModel::Serializer
    attributes :id, :status, :sender, :owner, :project, :read, :messages, :subject, :sender_email

    def sender
      # override Ticket#sender in an initializer if you need
      # anything beyond default serialization of a User object
      object.sender || object.messages.first&.sender || {}
    end

    def owner
      {
        id: object.owner&.id,
        username: object.owner&.username,
        real_name: object.owner&.real_name
      }
    end

    def project
      {
        id: object.project&.id,
        title: object.project&.title,
        slug: object.project&.slug
      }
    end

    def read
      object.messages.all?(&:read)
    end

    def subject
      return if object.messages.empty?
      object.messages.first.details[:subject]
    end

    def sender_email
      return if object.messages.empty?
      object.messages.first.details[:sender_email]
    end

    def messages
      object.messages.map do |message|
        {
          content: message.content,
          id: message.id,
          kind: message.kind,
          read: message.read,
          sender: message.sender || {},
          details: message.details,
          created_at: message.created_at,
          updated_at: message.updated_at
        }
      end
    end
  end
end
