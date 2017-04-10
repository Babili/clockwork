require "clockwork"
require "rest-client"

def trigger(url)
  RestClient.post(url, {}, {})
end

module Clockwork
  logger = Logger.new(STDOUT)

  configure do |config|
    config[:logger] = logger
  end

  engine_url = "http://#{ENV['ENGINE_HOST']}:#{ENV['ENGINE_PORT']}"

  every(80.seconds, "refresh statuses") do
    trigger("#{engine_url}/internal/refresh-statuses")
  end

  every(30.seconds, "notify users of unread messages") do
    trigger("#{engine_url}/internal/send-unread-messages")
  end
end
