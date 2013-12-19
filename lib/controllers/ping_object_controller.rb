require 'storage_adapters'
require 'models'

module Ping200
  module Controller
    #Controller for handeling ping objects. Returns pingobjects
    class PingObjectController
      class << self
        def all
          array_hash = StorageAdapter::PingObjectAdapter.new.all

          array_hash.map do | hash |
            Models::PingObject.new hash
          end
        end

        def get key
          hash = StorageAdapter::PingObjectAdapter.new.get key

          Models::PingObject.new hash
        end
      end
    end
  end
end

