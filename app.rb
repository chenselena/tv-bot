# frozen_string_literal: true

require 'sinatra'
require 'bunny'
require_relative 'app/slack_authorizer'
require_relative 'services/add_request_to_queue'

use SlackAuthorizer

FIRST_DEPLOY_MESSAGE = "Congratulations on your first deploy!!!!"
INVALID_RESPONSE = "Sorry! It doesn't look like that's a valid video."
HELP_RESPONSE = "Use /tvplay to play a video on the screens. Example: /tvplay fireworks"
RICKROLL = "you just got rickrolled xd"

get '/firework' do
  AddRequestToQueue.new.call("fireworks")
end

get '/rickroll' do
  AddRequestToQueue.new.call("rickroll")
end

post '/slack/command' do
  AddRequestToQueue.new.call("fireworks")
  AddRequestToQueue.new.call("rickroll")

  case params['text'].to_s.strip
  when 'help', '' then HELP_RESPONSE
  when 'firework', '' then FIRST_DEPLOY_MESSAGE  
  when 'rickroll', '' then RICKROLL
  else INVALID_RESPONSE
  end
end
