# frozen_string_literal: true

require 'sinatra'
require 'bunny'
require_relative 'app/slack_authorizer'

use SlackAuthorizer

FIREWORKS_RESPONSE = "Congratulations to %s for their first deploy!".freeze
INVALID_RESPONSE = "Sorry! It doesn't look like that's a valid video."
HELP_RESPONSE = "Use /tvplay to play a video on the screens. Example: /tvplay fireworks"

configure do
  connection = Bunny.new(ENV["CLOUDAMQP_CHARCOAL_URL"])
  connection.start
  channel = connection.create_channel
  channel.queue("npfs.slack.tvbot", :auto_delete => true)
  exchange = channel.default_exchange
end

get '/firework' do
  exchange.publish(command, :routing_key => queue.name)
  connection.close
end

post '/slack/command' do
  case params['text'].to_s.strip
  when 'help', '' then HELP_RESPONSE
  when 'firework', '' then FIREWORKS_RESPONSE
  else INVALID_RESPONSE
  end
end
