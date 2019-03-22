class CreateTicket < ActiveRecord::Migration[5.2]
  def change
    create_table :ticketing_engine_tickets do |t|
      t.references :course
      t.integer :owner_id, index: true
      t.integer :status, default: 0, limit: 1

      t.timestamps
    end
  end
end
