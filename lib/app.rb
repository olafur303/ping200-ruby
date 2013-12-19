# encoding: utf-8
require 'sinatra/base'
require 'sinatra/config_file'
require 'sinatra/json'
require 'rack'
require 'rack/session/cookie'
require 'digest/md5'
require 'thin'

require 'storage'
require 'controllers'
require 'login_key'
require 'routes'

module Ping200
  # Login middle ware controlling login between routes
  class LoginScreen < Sinatra::Base
    use Rack::Session::Cookie, :key => 'rack.session',
        :path                       => '/',
        :expire_after               => 2592000, # In seconds
        :secret                     => 'super_secret',
        :http_only                  => true

    get('/login') do
      if session['secret'] == ENV['LOGIN_KEY']
        redirect '/'
      end

      erb :login
    end

    get('/logout') do
      session[:secret] = "none";
      redirect '/login'
    end

    post('/login') do
      pass_hex = Digest::MD5.hexdigest(params[:name]+
                                         ":"+params[:password]+
                                         ":3xyzasd1239472731aksdhak")
      if pass_hex == ENV['LOGIN_KEY']
        session['secret'] = ENV['LOGIN_KEY']
        redirect '/'
      else
        redirect '/login'
      end
    end
  end
  #Main webserver class, all routes and controller dedication goes here
  class App < Sinatra::Base
    use LoginScreen
    register Sinatra::ConfigFile

    configure :stage do
      set :show_exceptions, true
    end
    configure :production do
      set :show_exceptions, false
    end

    configure do
      set :environments, %w{ development test stage production }
      config_file 'config.yml'
      Storage.setup settings.storage
    end

    error do
      json message: env['sinatra.error']
    end

    before do
      unless session['secret'] == ENV['LOGIN_KEY']
        redirect '/login'
      end
      cache_control :public, max_age: 60 * 60
    end

    register Ping200::Routes::Ping

    register Ping200::Routes::Site

    get '/' do
      #erb :index
      'logged in'
    end

    def halt_on(error, params, params_expected)
      params_expected.each do |key|
        halt error unless params.has_key? key
      end
    end
  end
end
