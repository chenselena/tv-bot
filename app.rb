# frozen_string_literal: true

require 'sinatra'

use SlackAuthorizer

post '/slack/command' do
  "OK"
end
