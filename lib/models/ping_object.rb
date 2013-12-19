module Ping200
  module Models
    #PORO for containing ping information
    class PingObject

      attr_accessor :key, :website, :timestamp, :ping, :response_time

      def initialize (object_hash = {})
        @key            = object_hash[:key]
        @website        = object_hash[:website]
        @timestamp      = object_hash[:timestamp]
        @ping           = object_hash[:ping]
        @response_time  = object_hash[:response_time]
      end

      def to_h
        to_h_with_nil.delete_if { |k, v| v.nil? }
      end

      def to_h_with_nil
        {
          key:           key,
          website:       website,
          timestamp:     timestamp,
          ping:          ping,
          response_time: responsetime
        }
      end
    end
  end
end

