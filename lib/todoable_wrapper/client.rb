require 'httparty'
require 'pry'

module TodoableWrapper
  class Client
    include HTTParty
    
    base_uri "https://todoable.teachable.tech/api"

    def initialize(u, p)
      @auth = { username: u, password: p }
      get_token    
    end

    def get_token
      # if token is expired, we need to refresh token
      begin
        options = { basic_auth: @auth }
        response = self.class.post('/authenticate', options)
        @token = JSON.parse(response.body)["token"]
      rescue => exception
        puts exception
        puts "Invalid credentials"
      end
    end

    def lists(options = {})
      options = { headers: {"Authorization" => "Token token=\"#{@token}\""} }
      response = self.class.get('/lists', options)
      # lists = JSON.parse(response.body)
      lists = JSON.parse([lists].to_json).first
      lists

    end

    def get_list_by_id(id)
      options = { headers: {"Authorization" => "Token token=\"#{@token}\""} }
      response = self.class.get("/lists/#{id}", options)
      # list = JSON.parse(response.body)
      list = JSON.parse([list].to_json).first
      list
    end

    def create_list(list_name)
      list = { list: {name: list_name} }
      options = { body: list.to_json, headers: {"Authorization" => "Token token=\"#{@token}\""} }
      response = self.class.post("/lists", options)
    end

  end
end