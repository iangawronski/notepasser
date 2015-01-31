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
  class MessageCreateController < R "/messages"
    def post
      new_message = Notepasser::Models::Message.new
      [:message_id, :message_text, :sender_id, :recipient_id].each do |p|
        new_message[p] = @input[p]
      end
      new_message.save
      @status = 201
      {:message => "Your #{message_id} message was created.", :code => 201, :post => new_message}.to_json
    end

    def get
      page = @input['page'].to_i || 1
      start = (page - 1) * 20
      finish = (page * 20) - 1
      Notepasser::Models::Message.where(:id => [start .. finish]).to_json
    end
  end

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
end


########### TODO: CREATE USER CONTROL AND CLIENT SIDE

#get message, delete message, create/post message, create new user, delete user, message read/unread
#Keep thinking may need more than just the above...
