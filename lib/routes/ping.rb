# encoding: utf-8
module Ping200
  module Routes
    module Ping
      def self.registered(app)
        app.get '/ping/all' do
          objects = Controller::PingObjectController.all()
          json events.map { |e| e.to_h }
        end

        app.get '/ping' do
          halt 500 unless params[:website]
          objects = Controller::PingObjectController.get params[:website]
          json events.map { |e| e.to_h }
        end
      end
    end
  end
end