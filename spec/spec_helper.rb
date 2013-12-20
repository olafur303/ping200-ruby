# encoding: utf-8
require 'fakeredis'

RSpec.configure do |config|
  config.before(:all) do
    # The tests are written with Swedish local time in mind
    ENV['TZ'] = 'CET'
    ENV['RACK_ENV'] = 'test'
  end

  config.after(:each) do
  end
end
