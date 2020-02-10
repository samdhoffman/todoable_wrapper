require "todoable_wrapper/version"
require 'httparty'
require 'pry'

Dir[File.dirname(__FILE__) + '/todoable_wrapper/*.rb'].each do |file|
  require file
end

# module TokenRefresher
#   def token=(val)
#     binding.pry
#     if operator
#       get_token
#     else
#       puts "we good"
#     end
#   end
# end

module TodoableWrapper
  class Client
    include HTTParty
    include TodoableWrapper::Client::List
    include TodoableWrapper::Client::Item

    base_uri "https://todoable.teachable.tech/api"

    def initialize(u, p)
      @auth = { username: u, password: p }
      get_token
    end

    # prepend TokenRefresher

    def get_token
      # if token is expired, we need to refresh token
      begin
        options = { basic_auth: @auth }
        response = self.class.post('/authenticate', options)
        @token = JSON.parse(response.body)["token"]
        @expires_at = JSON.parse(response.body)["expires_at"].to_datetime
      rescue => exception
        puts exception
        puts "Invalid credentials"
      end
    end

    # def lists(options = {})
    #   options = { headers: {"Authorization" => "Token token=\"#{@token}\""} }
    #   response = self.class.get('/lists', options)
    #   if response == "Unauthorized"
    #     # get new token
    #     get_token
    #     lists
    #   end
    #   binding.pry
    #   lists = JSON.parse(response.body)
    #   lists

    # end

    # def get_list_by_id(id)
    #   options = { headers: {"Authorization" => "Token token=\"#{@token}\""} }
    #   response = self.class.get("/lists/#{id}", options)
    #   list = JSON.parse(response.body)
    #   list
    # end

    # def create_list(list_name)
    #   list = { list: {name: list_name} }
    #   options = { body: list.to_json, headers: {"Authorization" => "Token token=\"#{@token}\""} }
    #   response = self.class.post("/lists", options)
    #   response.code
    # end

    # def update_list(id, list_name)
    #   list = { list: {name: list_name} }
    #   options = { body: list.to_json, headers: {"Authorization" => "Token token=\"#{@token}\""} }
    #   self.class.patch("/lists/#{id}", options)
    # end

    # def delete_list(id)
    #   options = { headers: {"Authorization" => "Token token=\"#{@token}\""} }
    #   response = self.class.delete("/lists/#{id}", options)
    #   response.code
    # end

    # def add_item(id, item_name)
    #   item = { item: {name: item_name} }
    #   options = { body: item.to_json, headers: {"Authorization" => "Token token=\"#{@token}\""} }
    #   response = self.class.post("/lists/#{id}/items", options)
    #   response.code
    # end

    # def delete_item(list_id, item_id)
    #   options = { headers: {"Authorization" => "Token token=\"#{@token}\""} }
    #   response = self.class.delete("/lists/#{list_id}/items/#{item_id}", options)
    #   response.code
    # end

    # def finish_item(list_id, item_id)
    #   options = { headers: {"Authorization" => "Token token=\"#{@token}\""} }
    #   response = self.class.put("/lists/#{list_id}/items/#{item_id}/finish", options)
    #   response.code
    # end
    private
    def validate_token
      if @expires_at && @expires_at < DateTime.now
        get_token
      end
    end


  end
end