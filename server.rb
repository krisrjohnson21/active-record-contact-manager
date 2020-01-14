require 'sinatra'
require_relative 'config/application'

set :bind, '0.0.0.0'  # bind to all interfaces

enable :sessions

get '/' do
  @contacts = Contact.all
  erb :index
end

get '/contacts/:id' do
  id = params["id"]
  @contact = Contact.find(id)
  erb :show
end

get '/new' do
  erb :new
end

post '/new' do
  first_name = params["first_name"]
  last_name = params["last_name"]
  phone_number = params["phone_number"]

  Contact.create(
    first_name: first_name,
    last_name: last_name,
    phone_number: phone_number
  )

  redirect '/'
end

post '/' do
  first_name = params["first_name"]
  last_name = params["last_name"]

  @contact = Contact.where(
    first_name: first_name,
    last_name: last_name
  )[0]

  if @contact
    erb :show
  else
    erb :index
  end
end
