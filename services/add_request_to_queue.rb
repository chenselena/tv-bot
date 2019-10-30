# frozen_string_literal: true

class AddRequestToQueue
  def initialize
    start_queue_connection
    @queue = @channel.queue("npfs.slack.tvbot", auto_delete: true)
    @exchange = @channel.default_exchange
  end

  def call(command)
    # TODO catch bad command
    # raise AurgmentError "Invalid command #{command}" unless ["fireworks", "rickroll", "gong"].include?(command)

    @exchange.publish(command, routing_key: @queue.name)
    @connection.close
  end

  private

  def start_queue_connection
    @connection = Bunny.new(ENV["CLOUDAMQP_CHARCOAL_URL"])
    @connection.start
    @channel = @connection.create_channel
  end
end
