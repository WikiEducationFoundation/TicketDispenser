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

  describe '.details' do
    let(:message) { create(:message) }
    it 'should return an empty hash if not set' do
      expect(message.details).to eq({})
    end
  end

  describe '#reply?' do
    it 'should return true if the message is a reply' do
      message = create(:message, kind: TicketDispenser::Message::Kinds::REPLY)
      expect(message.reply?).to be true
    end
    it 'should return false if the message is not a reply' do
      message = create(:message, kind: TicketDispenser::Message::Kinds::NOTE)
      expect(message.reply?).to be false
    end
  end
end
