# frozen_string_literal: true

# == Schema Information
#
# Table name: ticket_dispenser_messages
#
#  id         :bigint(8)        not null, primary key
#  kind       :integer          default(0)
#  sender_id  :integer
#  ticket_id  :bigint(8)
#  read       :boolean          default(FALSE), not null
#  content    :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


module TicketDispenser
  class Message < ApplicationRecord
    belongs_to :sender, class_name: :User, optional: true
    belongs_to :ticket

    serialize :details, Hash

    module Kinds
      REPLY = 0
      NOTE  = 1
    end

    validates :kind, numericality: true, inclusion: {
      in: Kinds.constants.map { |c| Kinds.const_get c }
    }
    validates :read, inclusion: { in: [true, false], message: "can't be blank" }
    validates :content, length: { minimum: 0, allow_nil: false }

    def reply?
      kind == Kinds::REPLY
    end

    # override this in the main app if you need to define a custom `sender`
    def serialized_sender
      sender
    end
  end
end
