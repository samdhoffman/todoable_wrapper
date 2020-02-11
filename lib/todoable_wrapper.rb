require "todoable_wrapper/version"
require 'httparty'

Dir[File.dirname(__FILE__) + '/todoable_wrapper/*.rb'].each do |file|
  require file
end

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

    def get_token
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
    
    private
    def validate_token
      if @expires_at && @expires_at < DateTime.now
        get_token
      end
    end

  end
end