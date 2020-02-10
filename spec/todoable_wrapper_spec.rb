require 'httparty'

RSpec.describe TodoableWrapper::Client do
  it "has a version number" do
    expect(TodoableWrapper::VERSION).not_to be nil
  end

  describe "default_attributes" do
    it "must include HTTParty" do
      expect(described_class).to include HTTParty
    end

    it "must have api base uri set to Todoable API endpoint" do
      expect(described_class).to have_attributes(:base_uri => "https://todoable.teachable.tech/api") # change to todoable api later
    end
  end

  # describe "#new" do
    # let(:client) { described_class.new('xxxx', 'xxxx') }

    # before do
    #   VCR.insert_cassette 'authenticate', :record => :new_episodes
    # end

    # after do
    #   VCR.eject_cassette
    # end

    # it "records the fixture" do
    #   client
    # end

  #   it "takes 2 parameters and returns a Client object" do
  #     expect(client).to be_instance_of(described_class)
  #   end

  #   it "must have a lists method" do
  #     expect(client).to respond_to(:lists)
  #   end

  #   it "must have get list by id method" do
  #     expect(client).to respond_to(:get_list_by_id)
  #   end
  # end

  describe "get token" do
    let(:token) { File.read('spec/fixtures/authenticate.json') }
    it "must return a token string" do
      stub_request(:get, "https://todoable.teachable.tech/api/authenticate").
        to_return(status: 200, body: token, headers: {})
        expect(JSON.parse(token)["token"]).to be_instance_of(String)
    end
  end

  describe "GET lists" do
    let(:lists) { File.read('spec/fixtures/lists.json') }
    it "must return an array of lists" do
      stub_request(:get, "https://todoable.teachable.tech/api/lists").
        to_return(status: 200, body: lists, headers: {})
        
      expect(JSON.parse(lists)["lists"]).to be_instance_of(Array)
    end
  end

  describe "GET list by id" do
    let(:list_info) { File.read('spec/fixtures/list_info.json') }
    it "looks up a list by id" do
      stub_request(:get, "https://todoable.teachable.tech/api/lists/12345").
        to_return(status: 200, body: list_info, headers: {})
        expect(list_info).to include("name")
        
    end
  end
  
end