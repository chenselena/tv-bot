# frozen_string_literal: true

require 'sinatra'
require 'bunny'
require_relative 'app/slack_authorizer'
require_relative 'services/add_request_to_queue'

use SlackAuthorizer

FIRST_DEPLOY_MESSAGE = 'Congratulations on your first deploy!!!!'
INVALID_RESPONSE = "Sorry! It doesn't look like that's a valid command."
HELP_RESPONSE = 'Use /tvplay to play a video on the screens. Example: /tvplay fireworks'
RICKROLL = 'Never gonna give them up!'
STAYING_ALIVE = "Ah, ha, ha, ha, stayin' alive, stayin' alive"

get '/fireworks' do
  AddRequestToQueue.new.call('fireworks')
end

get '/rickroll' do
  AddRequestToQueue.new.call('rickroll')
end

get '/stay-alive' do
  STAYING_ALIVE
end

post '/slack/command' do
  case params['text'].to_s.strip
  when 'help'
    HELP_RESPONSE
  when 'fireworks'
    AddRequestToQueue.new.call('fireworks')
    FIRST_DEPLOY_MESSAGE
  when 'rickroll'
    AddRequestToQueue.new.call('rickroll')
    RICKROLL
  when ':arrow_up::arrow_up:  :arrow_down::arrow_down:  :arrow_left: :arrow_right: :arrow_left::arrow_right: :b: :a:'
    AddRequestToQueue.new.call('konami')
    '1337 h4k3r'
  else
    INVALID_RESPONSE
  end
end
