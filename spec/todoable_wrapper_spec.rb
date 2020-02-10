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

  describe "#new" do
    let(:client) { File.read('spec/fixtures/authenticate.json') }

    it "authenticates client" do
      stub_request(:get, "https://todoable.teachable.tech/api/authenticate").
      to_return(status: 200, body: client, headers: {})
    end

    it "must include a token string" do
        expect(JSON.parse(client)["token"]).to be_instance_of(String)
    end

    it "must include a token expiration date" do
      expect(DateTime.parse(JSON.parse(client)["expires_at"])).to be_instance_of(DateTime)
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

  describe "POST new list" do
    let(:new_list) { File.read('spec/fixtures/new_list.json') }
    it "looks up a list by id" do
      stub_request(:post, "https://todoable.teachable.tech/api/lists").
        to_return(status: 201, body: new_list, headers: {})
      expect(new_list).to include("name")
    end
  end

  describe "DELETE list by id" do
    it "deletes a list by id" do
      stub_request(:delete, "https://todoable.teachable.tech/api/lists/12345").
        to_return(status: 204, headers: {})
    end
  end

  describe "POST new item" do
    let(:item) { File.read('spec/fixtures/item.json') }
    it "looks up a list by id" do
      stub_request(:post, "https://todoable.teachable.tech/api/lists/794fd7ba-adf6-4491-a427-98209be5a696/items").
        to_return(status: 204, body: item, headers: {})
      expect(item).to include("name")
    end
  end

  describe "POST to finish item" do
    it "marks an item in a list as finished" do
      stub_request(:post, "https://todoable.teachable.tech/api/lists/794fd7ba-adf6-4491-a427-98209be5a696/items/a0c72f88-3db2-4ef8-a3e7-0133ad7dfe31").
        to_return(status: 200, headers: {})
    end
  end

  describe "DELETE item by id" do
    it "deletes a list item by id" do
      stub_request(:delete, "https://todoable.teachable.tech/api/lists/794fd7ba-adf6-4491-a427-98209be5a696/items/a0c72f88-3db2-4ef8-a3e7-0133ad7dfe31").
        to_return(status: 204, headers: {})
    end
  end
  
end