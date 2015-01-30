class NotePasserUser < ActiveRecord::Migration
  def self.up
    create_table :user do |u|
      u.string :login #?
      u.integer :user_id
    end
  end

  def self.down
    drop_table :user
  end
end
