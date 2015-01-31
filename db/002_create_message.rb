class CreateMessage < ActiveRecord::Migration
  def self.up
    create_table :messages do |m|
      m.text :message_text
      m.integer :message_id, uniqueness: true
      m.integer :sender_id
      m.integer :recipient_id
      m.boolean :message_status, default: false
    end
  end

  def self.down
    drop_table :messages
  end
end
