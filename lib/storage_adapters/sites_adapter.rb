# encoding: utf-8
require 'storage_adapters'

module Ping200
  module StorageAdapter
    class SitesAdapter < GenericAdapter

      def initialize
        super("sites")
      end

      def add(object)
        key = object_key_generator storage_prefix + object.website.to_s
        store_event(key, object)
      end
    end
  end
end
