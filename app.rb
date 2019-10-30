# frozen_string_literal: true

require 'sinatra'

use App::SlackAuthorizer

post '/slack/command' do
  "OK"
end
