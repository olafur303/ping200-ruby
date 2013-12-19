require 'clockwork'
require 'yaml'
require 'storage'

require 'workers/poller'
require 'workers/initializer'

module Clockwork
  configure do
    Ping200::Storage.setup SETTINGS
  end

  handler do |job, time|
    puts "#{time} - Running #{job}"
  end

  every(10.minutes, 'polling') do
    Poller.do
  end
end
