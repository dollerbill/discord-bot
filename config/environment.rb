require 'dotenv/load'
require 'discordrb'
require 'faker'
require 'sequel'
require_relative '../Rakefile'
require_relative '../config/init/configure_sequel'
require_relative '../config/init/configure_models'
Dir['modes/*.rb'].each { |file| load file }
Dir['services/**/*.rb'].each { |file| load file }
