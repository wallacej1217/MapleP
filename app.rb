require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './models'
require 'mailgun'
require 'mail'

require 'sendgrid-ruby'
include SendGrid
# Database configuration
set :database, "sqlite3:development.sqlite3"

# Define routes below
get '/' do
  erb :index
end

get '/resources' do
  erb :resources
end

get '/pms' do
  erb :pms
end

get '/SM' do
  erb :SM
end

get '/DW' do
  erb :DW
end

get '/contact' do
  erb :contact
end

get '/AboutUs' do
  erb :AboutUs
end

post "/submit" do
  @mail = params[:mail]
  @message = params[:user_message]



  from = SendGrid::Email.new(email: @mail)
  subject = @message
  to = SendGrid::Email.new(email: "associatesofmaple@comcast.net")
  content = SendGrid::Content.new(type: 'text/plain', value: @message)

  mail = SendGrid::Mail.new(from, subject, to, content)
  #
  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  #
  # p mail

  response = sg.client.mail._('send').post(request_body: mail.to_json)
end


#  post "/submit" do
#   @email = params[:mail]
#   @message = params[:user_message]
#
#   # First, instantiate the Mailgun Client with your API key
#   mg_client = Mailgun::Client.new 'your api key'
#
#   # Define your message parameters
#   message_params =  { from: @email,
#                       to:   'admin@associatesofmaple.me',
#                       subject: 'The Ruby SDK is awesome!',
#                       text: @user_message
#                     }
#
#   # Send your message through the client
#   mg_client.send_message 'https://api.mailgun.net/v3/sandbox275a7519749c44b1af047c06143acc83.mailgun.org', message_params
# end
