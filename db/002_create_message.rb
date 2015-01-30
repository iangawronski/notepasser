class CreateMessage < ActiveRecord::Migration
  def self.up
    create_table :message do |m|
      m.text :message
      m.integer :message_id
      m.string :user
      m.integer :user_id
    end
  end

  def self.down
    drop_table :message
  end
end
