# frozen_string_literal: true

require 'sinatra'
require 'bunny'
require_relative 'app/slack_authorizer'
require_relative 'services/add_request_to_queue'

use SlackAuthorizer

FIREWORKS_RESPONSE = "Congratulations to %s for their first deploy!".freeze
INVALID_RESPONSE = "Sorry! It doesn't look like that's a valid video."
HELP_RESPONSE = "Use /tvplay to play a video on the screens. Example: /tvplay fireworks"

get '/firework' do
  AddRequestToQueue.new.call("firework")
end

post '/slack/command' do
  case params['text'].to_s.strip
  when 'help', '' then HELP_RESPONSE
  when 'firework', '' then FIREWORKS_RESPONSE
  else INVALID_RESPONSE
  end
end
