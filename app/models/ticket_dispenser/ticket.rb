# frozen_string_literal: true

module TicketDispenser
  class Ticket < ApplicationRecord
    belongs_to :project, class_name: 'Course', optional: true
    belongs_to :owner, class_name: :User, optional: true

    has_many :messages, dependent: :destroy

    # These statuses are connected to the statuses that are set
    # in the dashboard's tickets/util.jsx file. If you change them
    # here, you should change them there.
    module Statuses
      OPEN = 0
      AWAITING_RESPONSE = 1
      RESOLVED = 2
    end

    validates :status, numericality: true, inclusion: {
      in: Statuses.constants.map { |c| Statuses.const_get c }
    }

    def reply_to
      messages.first.sender
    end

    def recipients
      senders = messages.map(&:sender)
      senders.uniq
    end

    def other_recipient(user)
      recipients.reject { |recipient| recipient == user }.first
    end
  end
end
