require 'storage_adapters'
require 'models'

module Ping200
  module Controller
    #Controller for handeling sites. Returns site objects
    class SitesController
      class << self
        def all
          array_hash = StorageAdapter::SitesAdapter.new.all

          array_hash.map do | hash |
            Models::SiteObject.new hash
          end
        end

        def add website
          model = Models::SiteObject.new({
            website: website.to_s
          })

          StorageAdapter::SitesAdapter.new.add model
        end

        def del key
          StorageAdapter::SitesAdapter.new.del key
        end

        def get key
          hash = StorageAdapter::SitesAdapter.new.get key

          Models::SiteObject.new hash
        end
      end
    end
  end
end

