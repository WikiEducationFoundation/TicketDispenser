# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TicketDispenser::Message, type: :model do
  it 'has a valid factory' do
    message = build(:message)
    expect(message).to be_valid
  end

  describe 'validations and associations' do
    let(:message) { build(:message) }

    it { expect(message).to validate_numericality_of(:kind) }
    it {
      values = TicketDispenser::Message::Kinds.constants.map do |constant|
        TicketDispenser::Message::Kinds.const_get constant
      end
      higher_val = values.max + 1
      expect(message).not_to allow_value(higher_val).for(:kind)
    }
    it { expect(message).to validate_presence_of(:read) }

    it { expect(message).not_to allow_value(nil).for(:content) }
    it { expect(message).to allow_value('').for(:content) }
    it { expect(message).to allow_value('Hello').for(:content) }

    it { expect(message).to belong_to(:ticket) }
  end
end
