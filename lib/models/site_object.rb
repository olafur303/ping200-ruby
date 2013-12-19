module Ping200
  module Models
    #PORO for containing ping information
    class SiteObject

      attr_accessor :key, :website

      def initialize (object_hash = {})
        @key            = object_hash[:key]
        @website        = object_hash[:website]
      end

      def to_h
        to_h_with_nil.delete_if { |k, v| v.nil? }
      end

      def to_h_with_nil
        {
          key:           key,
          website:       website
        }
      end
    end
  end
end

