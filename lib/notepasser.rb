require "notepasser/version"
require "notepasser/init_db"
require "camping"
require "pry"

Camping.goes :Notepasser

module Notepasser
  module Notepasser::Models
    class NotePasserUser < Base
      has_many :messages
    end

    class CreateMessage < Base
      belongs_to :user
    end
  end
end

module Notepasser::Controllers
  class MessageContorller < R '/messages/(\d+)'
    def get(message_id)
      message = Notepasser::Models::Message.find(message_id)
      message.to_json
    rescue ActiveRecord::RecordNotFound
      @status = 404
      "404 - message not found!"
    end

    def delete(message_id)
      message = Notepasser::Models::Message.find(message_id)
      message.destroy
      @status = 204
    rescue ActiveRecord::RecordNotFound
     @status = 404
      "404 - message not found, unable to delete message"
    end
  end

#get message, delete message, create/post message, create new user, delete user, message read/unread
#Keep thinking may need more than just the above...
