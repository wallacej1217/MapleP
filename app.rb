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
