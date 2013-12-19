ENV['RACK_ENV'] || ENV['RACK_ENV'] = 'development'
config = YAML.load(File.open('lib/config.yml'))
SETTINGS = config[ENV['RACK_ENV'].to_sym][:storage]

