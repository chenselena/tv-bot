# frozen_string_literal: true

require 'sinatra'
require_relative 'app/slack_authorizer'

use SlackAuthorizer

FIREWORK_CONGRATS = "Congratulations to %s for their first deploy!".freeze
INVALID_RESPONSE = "Sorry! It doesn't look like that's a valid video."

post '/slack/command' do
  case params['text'].to_s.strip
  when 'firework', '' then FIREWORK_CONGRATS
  else INVALID_RESPONSE
  end
end
