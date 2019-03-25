module TicketDispenser
  class TicketSerializer < ActiveModel::Serializer
    attributes :id, :status, :sender, :owner, :course, :messages

    def sender
      return nil if self.object.messages.empty?
      message = self.object.messages.find do |message|
        !message.sender.admin?
      end
      
      message.sender.username
    end
    
    def owner
      {
        id: self.object.owner.id,
        username: self.object.owner.username,
        real_name: self.object.owner.real_name
      }
    end

    def course
      {
        id: self.object.course.id,
        title: self.object.course.title,
        slug: self.object.course.slug
      }
    end
    
    def messages
      self.object.messages.map do |message|
        {
          content: message.content,
          id: message.id,
          kind: message.kind,
          read: message.read,
          sender: message.sender.username,
          created_at: message.created_at
        }
      end
    end
  end
end