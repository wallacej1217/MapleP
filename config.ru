require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

require 'mailgun'
require 'mail'

require 'sendgrid-ruby'

require './app'
require './models'

run Sinatra::Application
