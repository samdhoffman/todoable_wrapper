require 'httparty'

RSpec.describe TodoableWrapper::Client do
  describe "default_attributes" do
    it "must include HTTParty" do
      expect(described_class).to include HTTParty
    end

    it "must have api base uri set to Todoable API endpoint" do
      expect(described_class).to have_attributes(:base_uri => "https://todoable.teachable.tech/api") # change to todoable api later
    end
  end

  describe "#new" do
    let(:client) { described_class.new('xxxx', 'xxxx') }

    before do
      VCR.insert_cassette 'authenticate', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    it "records the fixture" do
      client
    end

    it "takes 2 parameters and returns a Client object" do
      expect(client).to be_instance_of(described_class)
    end

    it "must set token instance variable" do
      expect(client.instance_variable_get(:@token)).to eq("06e4d7f1-392c-4b8a-acad-d111ee615729")
    end
  end

  describe "GET lists" do
    let(:client) { described_class.new('samdhoffman@gmail.com', 'todoable') }
    let(:lists) { client.lists }

    before do
      VCR.insert_cassette 'lists', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    it "records the fixture" do
      lists
    end

    it "response must have lists as an attribute" do
      expect(lists).to include("lists")
    end

    it "must return an array of lists" do
      expect(lists["lists"]).to be_instance_of(Array)
    end

    it "must have a lists method" do
      expect(client).to respond_to(:lists)
    end
  end
  
end