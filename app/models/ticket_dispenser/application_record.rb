# frozen_string_literal: true

module TicketDispenser
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
