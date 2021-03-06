# frozen_string_literal: true

class CreateTicket < ActiveRecord::Migration[5.2]
  def change
    create_table :ticket_dispenser_tickets do |t|
      t.references :project
      t.integer :owner_id, index: true
      t.integer :status, default: 0, limit: 1

      t.timestamps
    end
  end
end
