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
      binding.pry
      # redirect to get token if unauthorized
      puts response
    end

    def get_list_by_id(id)
      options = { headers: {"Authorization" => "Token token=\"#{@token}\""} }
      response = self.class.get("/lists/#{id}", options)
      list = JSON.parse(response.body)
      binding.pry
      list
    end

  end
end