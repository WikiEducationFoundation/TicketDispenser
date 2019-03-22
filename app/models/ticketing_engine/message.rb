# frozen_string_literal: true

module TicketingEngine
  class Message < ApplicationRecord
    belongs_to :sender, class_name: :User
    belongs_to :ticket

    module Kinds
      REPLY = 0
      NOTE  = 1
    end

    validates :kind, numericality: true, inclusion: {
      in: Kinds.constants.map { |c| Kinds.const_get c }
    }
    validates :read, inclusion: { in: [true, false], message: "can't be blank" }
    validates :content, length: { minimum: 0, allow_nil: false }
  end
end