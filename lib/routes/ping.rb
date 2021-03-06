# encoding: utf-8
module Ping200
  module Routes
    module Ping
      def self.registered(app)
        app.get '/ping/all' do
          objects = Controller::PingObjectController.all()
          json objects.map { |o| o.to_h }
        end

        app.get '/ping' do
          halt 500 unless params[:key]
          objects = Controller::PingObjectController.get params[:key]
          json objects.map { |o| o.to_h }
        end
      end
    end
  end
end
