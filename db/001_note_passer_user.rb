class NotePasserUser < ActiveRecord::Migration
  def self.up
    create_table :users do |u|
      u.string :login
      u.integer :login_id
    end
  end

  def self.down
    drop_table :users
  end
end
