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
  class MessageCreateController < R '/messages'
    def post
      new_message = Notepasser::Models::Message.new
      [:message_id, :message_text, :sender_id, :recipient_id].each do |p|
        new_message[p] = @input[p]
      end
      new_message.save
      @status = 201
      {:message => "Your #{new_message.id} message was created.", :code => 201, :post => new_message}.to_json
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

  class ReadMessageContoller < R '/messages/(\d+)'
    def put
      message = Notepasser::Models::Message.find(message_id)
      message.update_attribute(:message_status => true)
      message.save
    end
  end

  class UnreadMessageController < R '/messages/(\d+)'
    def put
      message = Notepasser::Models::Message.find(message_id)
      message.update_attribute(:message_status => false)
      message.save
    end
  end

  class CreateUserController < R '/users'
    def post
      new_user = Notepasser::Models::User.new_message
      [:login, :login_id].each do |u|
        new_user[u] = @input[u]
      end
      new_user.save
      @status = 201
      {:message => "Congrats, #{new_user} for creating your login." :code => 201, :post => new_user}.to_json
    end
  end

  class UserController < R '/users/(\d+)'
    def get(login_id)
      user = Notepasser::Models::User.find(login_id)
    rescue ActiveRecord::RecordNotFound
      @status = 404
      "404 - unable to locate user."
    end

    def detlete(login_id)
      user = Notepasser::Models::User.find(login_id)
      user.destroy
      @status = 204
    rescue ActiveRecord::RecordNotFound
      @status = 404
      "404 - User not found."
    end
  end
end


########### TODO: CREATE USER CONTROL AND CLIENT SIDE

#### DONE:
# create message, delete message, get message, create new user, delete user,

#### TODO:
# user id???

#get message, delete message, create/post message, create new user, delete user, message read/unread
#Keep thinking may need more than just the above...
