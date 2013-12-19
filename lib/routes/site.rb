# encoding: utf-8
module Ping200
  module Routes
    module Site
      def self.registered(app)
        app.get '/site/all' do
          sites = Controller::SitesController.get_all
          json sites.to_h
        end

        app.post '/site/add' do
          halt 500 unless params[:website]
          object = Controller::SitesController.add params[:website]
          json object.to_h
        end

        app.delete '/site/delete' do
          halt 500 unless params[:website]
          object = Controller::SitesController.add_site params[:website]
        end
      end
    end
  end
end
