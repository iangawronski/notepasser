require 'httparty'

class NotePasserClient
  include HTTParty
  base_uri 'http://10.0.0.11' #or is it 'http://10.0.0.11:3301' ???

  def add_user(login = "Gawronski")
    print "Please enter a new login name: "
    login = gets.chomp
    opitions = {:login => login}
    self.class.post("/user", :body => options)

  def get_user(login_id)
    result = self.class.get("/users/#{login_id}")
    JSON.parse(result.body)
  end

  def delete_user(login_id)
    print "Would you like to delete #{login_id}, answer Y or N"
    answer = gets.chomp.upcase
    if answer != "N"
      result = self.class.destroy("/users/#{login_id}")
    else
      break
    end
  end

  def list_all_users
    result = self.class.get)"/users"
    users = JSON.parse(result.body)
    login_info = []
    users.each do |x|
      login_info << get_login(x['login'])
    end
    return login_info
  end

  def create_and_send_message
    print "Plese provide the ID of the individual you are trying to message: "
    recipient_id = gets.chomp
    print "Please enter what you would like to incude in your message's body: "
    message_text = gets.chomp
    print "Now, please provide your user id below: "
    sender_id = gets.chomp
    opts = {:message_text => message_text, :recipient_id => recipient_id, :sender_id => sender_id}
    result = self.class.post("/messages", :body => options)
  end

  def get_message(message_id)
    result = self.class.get("/messages/#{message_id}")
    JSON.parse(result.body)
  end

  def delete_message(message_id)
    result = self.class.destroy("/messages/#{message_id}")
  end

  def message_is_read(message_id)
    options = {:message_status => message_status}
    result = self.class.put {"/messages/#{message_id}", :body => options}
  end

  def message_is_unread(message_id)
    options = {:message_status => message_status}
    result = self.class.delete("/messages/#{message_id}", :body => options)
  end
end

login = NotePasserClient.new

