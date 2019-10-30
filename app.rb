# frozen_string_literal: true

require 'sinatra'
require_relative 'app/slack_authorizer'
require_relative 'app/add_request_to_queue'

use SlackAuthorizer
use AddRequestToQueue

FIREWORKS_RESPONSE = "Congratulations to %s for their first deploy!".freeze
INVALID_RESPONSE = "Sorry! It doesn't look like that's a valid video."
HELP_RESPONSE = "Use /tvplay to play a video on the screens. Example: /tvplay fireworks"

post '/slack/command' do
  case params['text'].to_s.strip
  when 'help', '' then HELP_RESPONSE
  when 'firework'
    FIREWORKS_RESPONSE
    AddRequestToQueue.new.call("firework")
  else INVALID_RESPONSE
  end
end
