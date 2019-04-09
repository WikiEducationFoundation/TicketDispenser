# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TicketDispenser::Ticket, type: :model do
  let(:ticket) { build(:ticket) }

  it 'has a valid factory' do
    ticket = build(:ticket)
    expect(ticket).to be_valid
  end

  describe 'validations and associations' do
    it { expect(ticket).to validate_numericality_of(:status) }
    it {
      values = TicketDispenser::Ticket::Statuses.constants.map do |constant|
        TicketDispenser::Ticket::Statuses.const_get constant
      end
      higher_val = values.max + 1
      expect(ticket).not_to allow_value(higher_val).for(:status)
    }
  end

  describe '#reference_id' do
    it 'returns the id as a padded string' do
      ticket[:id] = 1
      expect(ticket.reference_id).to eq('000001')
    end
  end
end
