# encoding: utf-8
require 'spec_helper'
require 'app'
require 'test/unit'
require 'rack/test'

ENV['LOGIN_KEY'] = '0c87b93c24795221b26ff5f5429d0475'

describe Ping200::App do
  include Rack::Test::Methods

  let :credentials do
    { :name => 'admin', :password => 'admin' }
  end

  def app
    Ping200::App
  end

  before :all do
    Ping200::Storage::client.redis.flushall
  end

  before :each do
    post '/login', credentials
  end
end
