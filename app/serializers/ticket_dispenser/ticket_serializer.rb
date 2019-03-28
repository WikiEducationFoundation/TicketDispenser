# frozen_string_literal: true

module TicketDispenser
  class TicketSerializer < ActiveModel::Serializer
    attributes :id, :status, :sender, :owner, :course, :messages

    def sender
      return nil if object.messages.empty?

      admin_message = object.messages.find do |message|
        !message.sender&.admin?
      end

      return nil if !admin_message
      admin_message.sender&.username
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

    def messages
      object.messages.map do |message|
        {
          content: message.content,
          id: message.id,
          kind: message.kind,
          read: message.read,
          sender: message.sender&.username,
          created_at: message.created_at
        }
      end
    end
  end
end
