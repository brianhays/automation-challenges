## Description

app.rb is a Sinatra application that will perform the tasks specified in this project's [README file](README.md)

## Requirements
In order to run this application and the associated rspec test file. Your machine will need the following installed:
 * ruby
 * rubygems
 * sqlite
 * bundler

## Usage Instructions
Initial setup:
* Clone this project to your local workstation or server. If your machine meets the above requirements, simply run `bundle install` from within the "rest api" directory to load the required gems.

Rspec tests can be run via:
```
rspec app_spec.rb
```

To run the application execute:
```
ruby app.rb
```
Once the app is up and running, functionality can be seen and tested by using the curl command as follows:

To send PUT requests to /words/"WORDNAME"
```
curl -X PUT -H "Content-Type: application/json" -d '{"word": "awesome"}' http://0.0.0.0:4567/words/awesome
```

Send GET requests to /words/"WORDNAME"
```
curl http://0.0.0.0:4567/words/awesome
```

Send GET requests to /words
```
curl http://0.0.0.0:4567/words
```