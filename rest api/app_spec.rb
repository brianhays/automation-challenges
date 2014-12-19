require_relative 'app'
require 'rack/test'

set :environment, :test

def app
  Sinatra::Application
end

describe "Word API Service" do
  include Rack::Test::Methods


# cleanup database before running tests
  before(:each) do
    Word.all.destroy
  end

# make we're up and running
  it "App is up and running" do
    get '/words'
    expect(last_response).to be_ok
  end

# allow PUT requests with "word" to /words/"word"
  it "Accepts PUT requests to /word/WORDNAME" do
    expect(Word.count).to eq(0)

    # PUT request to create word "testword"
    put '/words/testword', {"word" => "testword"}.to_json

    # test database count
    expect(Word.count).to eq(1)

    # test word save correctly in database
    expect(Word.first.word).to eq("testword")
  end

# error if PUT requests contain more than one word
  it "Error if PUT contains more than one word value" do
    expect(Word.count).to eq(0)

    # PUT request to create word "testword testword2"
    put '/words/testword', {"word" => "testword testword2"}.to_json

    # test database count again to make sure not saved
    expect(Word.count).to eq(0)

    # Error message (not ok)
    expect(last_response).not_to be_ok
  end

# error if PUT requests contain empty word value
  it "Error if PUT contains an empty word value" do
    expect(Word.count).to eq(0)

    # PUT request to create word "testword testword2"
    put '/words/testword', {"word" => ""}.to_json

    # test database count again to make sure not saved
    expect(Word.count).to eq(0)

    # Error message (not ok)
    expect(last_response).not_to be_ok
  end

# Accept GET requests to /words/WORDNAME
  it "Accept GET requests to /words/WORDNAME" do
    get '/words/testword'
    expect(last_response).to be_ok
  end

# Accept GET requests to /words
  it "Accept GET requests to /words" do
    get '/words'
    expect(last_response).to be_ok
  end

end