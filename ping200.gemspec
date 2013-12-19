# encoding: utf-8

$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'Ping200'
  s.version     = '0.1'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Vendre","Karl Litterfeldt"]

  s.homepage    = "Http://www.vendre.se"
  s.summary     = %q{}
  s.description = %q{}

  s.files       = Dir.glob("lib/**/*") + %w(Gemfile ping200.gemspec)
  s.test_files  = Dir.glob('spec/**/*')

  s.add_dependency 'sinatra'
  s.add_dependency 'sinatra-contrib'
  s.add_dependency 'redis'
  s.add_dependency 'redis-namespace'
  s.add_dependency 'thin'
  s.add_dependency 'clockwork'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rack-test'
  s.add_development_dependency 'fakeredis'
end
