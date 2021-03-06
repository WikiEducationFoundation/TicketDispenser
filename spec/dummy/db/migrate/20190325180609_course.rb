# frozen_string_literal: true

class Course < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :title
      t.string :slug
      t.timestamps
    end
  end
end
