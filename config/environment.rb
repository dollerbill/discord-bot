require 'dotenv/load'
require 'discordrb'
require 'faker'
require 'sequel'
require 'toil'
require_relative '../Rakefile'
require_relative '../config/init/configure_sequel'
require_relative '../config/init/configure_models'
Dir['modes/*.rb'].each { |file| load file }
Dir['services/**/*.rb'].each { |file| load file }

APP = OpenStruct.new
APP.env = ENV['RACK_ENV']
APP.is_heroku = ENV['is_heroku'] == 'true'
APP.root = Pathname.new(File.expand_path('..', __dir__)).freeze
APP.config_dir = APP.root.join('config').freeze

APP.define_singleton_method(:production?) { APP.env == 'production' }
APP.production = APP.production?

APP.require_deps = proc do |*dirs|
  dirs += %w[** *.rb]
  Dir[APP.root.join(*dirs)].sort.each { |f| require f }
end

APP.load_deps = proc do |*dirs|
  dirs += %w[** *.rb]
  Dir[APP.root.join(*dirs)].sort.each { |f| load f }
end
