require 'rubygems'
require 'bundler'

Bundler.require

# Setting up an in-memory sqlite db
DataMapper.setup(:default, 'sqlite::memory:')

class Word
  include DataMapper::Resource
  property :word, String, :key => true, :required => true
  property :count, Integer, :default => 1
  validates_presence_of :word
end

DataMapper.finalize
DataMapper.auto_upgrade!

set :bind, '0.0.0.0' # Listening on all interfaces

# custom message for 400 error code
error 400 do
  {"error" => "PUT requests must be one word in length"}.to_json
end


# handling PUT requests to /words/:word
put '/words/:word' do 
  this_word = JSON.parse(request.body.read)
  halt 400 if this_word.values.reduce.split.count != 1
  if this_word['word'] == params[:word]
    the_word = Word.first(:word => params[:word])
    if the_word
      the_word.update(:count => the_word['count'] + 1)
    else
      status 201
      the_word = Word.create(:word => params[:word])
    end
    "word #{the_word.word} has been sent #{the_word.count} times".to_json
  else
    "The word in your request must match the URL you're sending to. Please try again.".to_json
  end
end


# handling GET requests to /words/:word
get '/words/:word' do
  content_type :json
  the_word = Word.first(:word => params[:word])
  if the_word
    {the_word['word'] => the_word['count']}.to_json
  else
    "No word here by that name. Send us a request!".to_json
  end
end


# handling GET requests to /words
get '/words' do
  word_hash = {}
  Word.all.each { |w| word_hash.store(w.word, w.count) }
  word_hash.to_json
end