# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TicketDispenser::Ticket, type: :model do
  it 'has a valid factory' do
    ticket = build(:ticket)
    expect(ticket).to be_valid
  end

  describe 'validations and associations' do
    let(:ticket) { build(:ticket) }

    it { expect(ticket).to validate_numericality_of(:status) }
    it {
      values = TicketDispenser::Ticket::Statuses.constants.map do |constant|
        TicketDispenser::Ticket::Statuses.const_get constant
      end
      higher_val = values.max + 1
      expect(ticket).not_to allow_value(higher_val).for(:status)
    }
  end
end
