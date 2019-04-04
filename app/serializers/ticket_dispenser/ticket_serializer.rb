# frozen_string_literal: true

module TicketDispenser
  class TicketSerializer < ActiveModel::Serializer
    attributes :id, :status, :sender, :owner, :course, :read, :messages

    def sender
      object.messages.first.sender&.username
    end

    def owner
      {
        id: object.owner.id,
        username: object.owner.username,
        real_name: object.owner.real_name
      }
    end

    def course
      {
        id: object.course&.id,
        title: object.course&.title,
        slug: object.course&.slug
      }
    end

    def read
      object.messages.all?(&:read)
    end

    def messages
      object.messages.map do |message|
        {
          content: message.content,
          id: message.id,
          kind: message.kind,
          read: message.read,
          sender: message.sender&.username,
          created_at: message.created_at,
          updated_at: message.updated_at
        }
      end
    end
  end
end
