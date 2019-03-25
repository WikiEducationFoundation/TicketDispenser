class User < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :real_name
      t.timestamps
    end
  end
end
