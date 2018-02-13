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

# GET /contacts/new
get '/contacts/new' do
  erb :'contacts/new'
end

# GET /contacts/:index
get '/contacts/:index' do
  @index = params[:index].to_i
  contacts = read_contacts
  @contact = contacts[@index]

  erb :'contacts/show'
end

get '/contacts/:index/edit' do
  @index = params[:index].to_i
  contacts = read_contacts
  @contact = contacts[@index]

  erb :'contacts/edit'
end

# POST /contacts
post '/contacts' do
  new_contact = {
    name:  params[:name],
    phone: params[:phone],
    email: params[:email]
  }

  contacts = read_contacts
  contacts << new_contact
  write_contacts(contacts)

  index = contacts.length - 1

  redirect "/contacts/#{index}"
end

patch '/contacts/:index' do
  index = params[:index].to_i

  updated_contact = {
    name:  params[:name],
    phone: params[:phone],
    email: params[:email]
  }

  contacts = read_contacts
  contacts[index] = updated_contact
  write_contacts(contacts)

  redirect "/contacts/#{index}"
end
