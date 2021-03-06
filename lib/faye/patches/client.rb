module Faye
  module Patches

    def stop!
      @state = Faye::Client::DISCONNECTED

      info('Disconnecting ?', @dispatcher.client_id)
      @dispatcher.close
      info('Clearing channel listeners for ?', @dispatcher.client_id)
      @channels = Channel::Set.new
      @response_callbacks = {}
      true
    end

    def reconnect(&block)
      @reconnect_callback = block
      connect
    end

  end
end

Faye::Client.send(:include, Faye::Patches)
