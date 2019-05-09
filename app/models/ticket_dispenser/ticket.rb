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
  class Ticket < ApplicationRecord
    belongs_to :project, class_name: 'Course', optional: true
    belongs_to :owner, class_name: :User, optional: true

    has_many :messages, dependent: :destroy

    scope :open, -> { where(status: Statuses::OPEN) }

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

    def subject
      return if messages.empty?
      messages.first.details[:subject]
    end

    def reference_id
      id.to_s.rjust(6, '0')
    end

    def reply_to
      messages.first.sender
    end

    def in_recipient_list?(id)
      ids = messages.map(&:sender_id).uniq
      ids.include?(id)
    end

    # override this in the main app if you need to define a custom `sender`
    def sender
      nil
    end
  end
end
