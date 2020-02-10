require "todoable_wrapper/version"

Dir[File.dirname(__FILE__) + '/todoable_wrapper/*.rb'].each do |file|
  require file
end

module TodoableWrapper
  attr_accessor :api_key

  class Error < StandardError; end
  # Your code goes here...

  def self.client(username, password)
    @client ||= Client.new(username, password)
    puts "hi there"
  end

  # def self.api
  #   @api || raise("please set the api key")
  # end

  # def self.api=(api_key)
  #   @client = Client.new(api_key)
  #   @api = api_key
  # end
end
