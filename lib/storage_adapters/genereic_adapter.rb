# encoding: utf-8
require 'storage'
require 'json'

module Ping200
  module StorageAdapter
    #generic storage adapter, contains help methods for the rest of them
    class GenericAdapter
      attr_reader :storage_prefix

      def initialize (prefix = '')
        @storage_prefix = prefix
      end

      def get key
        get_object key
      end

      def all
        Storage::client.smembers(storage_prefix).map do |member|
          get_object(member)
        end
      end

      def del_event(key)
        #first remove the key from the set
        rem_set key, ''

        #remove the actual object
        rem_event key
      end

      #Storage interfacing methods
      private

      def store_event(key, object)
        object.key = key.to_s

        value = object.to_h

        #First add the actual object represented as a hash
        new_obj key, value

        #add key to set
        add_set key, ''

        object
      end

      def get_object(key)
        JSON.parse(Storage::client.get(key))
        .inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
      end

      def object_key_generator(value)
        value.gsub(/[^0-9a-z]/i, '').to_i(36)
      end

      def concat( *args )
        args.join
      end

      def new_obj(key,value)
        Storage::client.set(key,JSON.dump(value))
      end

      def rem_obj(key)
        Storage::client.del(key)
      end

      def add_set(key,*args)
        Storage::client.scache(storage_prefix+concat(args)) {key}
      end

      def rem_set(key, *args)
        Storage::client.srem(storage_prefix+concat(args), key)
      end
    end
  end
end
