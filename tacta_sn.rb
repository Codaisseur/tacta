require 'sinatra'

require './contacts_file'

# GET /
get '/' do
  "<h1>Tacta Contact Manager</h1>"
end

# GET /contacts
get '/contacts' do
  @contacts = read_contacts
  erb :'contacts/index'
end
