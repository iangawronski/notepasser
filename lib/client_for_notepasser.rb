require 'httparty'

class NotePasserClient
  include HTTParty
  base_uri 'http://10.0.0.11' #or is it 'http://10.0.0.11:3301' ???

  def get_user(login_id)
    result = self.class.get("/users/#{login_id}")
    JSON.parse(result.body)
  end

  def list_all_users(login_id)
    result = self.class.get
