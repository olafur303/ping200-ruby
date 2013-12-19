require 'storage_adapters'
require 'models'

module Ping200
  module Controller
    #Controller for handeling ping objects. Returns pingobjects
    class MonthlyEvent < Event
      class << self
        def all
          array_hash = StorageAdapter::PingAdapater.new.all

          array_hash.map do | hash |
            Model::PingObject.new hash
          end
        end

        def get key
          hash = StorageAdapter::PingAdapter.new.get key

          Model::PingObject.new hash
        end
      end
    end
  end
end

