require 'storage_adapters'
require 'models'
require 'curb'

module Clockwork
  #Framework for polling
  class Poller
    class << self
      def do
        self.new.poll
      end
    end

    def poll
      websites.each do |obj|
        data = Curl::Easy.perform(obj[:website])
        model = ping_model.new ({
          website: data.url,
          timestamp: Time.now.to_s,
          ping: data.status,
          response_time: data.total_time.to_s
        })
        add_ping_object model
        puts "sucess #{data.url}, #{data.status}, #{data.total_time.to_s}"
      end
    end

    private

    def ping_model
      Ping200::Models::PingObject
    end

    def ping_storage_adapter
      Ping200::StorageAdapter::PingObjectAdapter.new
    end

    def websites_storage_adapter
      Ping200::StorageAdapter::SitesAdapter.new
    end

    def add_ping_object object
      ping_storage_adapter.add object
    end

    def websites
      websites_storage_adapter.all
    end
  end
end

