require 'dotenv/load'
require 'sequel'
require 'rake/testtask'
require 'pathname'

namespace :db do
  desc 'Run migrations'
  task :migrate, [:version] do |t, args|
    require 'sequel/core'
    Sequel.extension :migration
    version = args[:version].to_i if args[:version]
    Sequel.connect(ENV['DATABASE_URL']) do |db|
      Sequel::Migrator.run(db, 'db/migrations', target: version)
    end
  end

  desc 'Drop, create, and migrate the database'
  task :reset do
    Rake::Task['db:migrate'].invoke(0)
    Rake::Task['db:migrate'].reenable
    Rake::Task['db:migrate'].invoke
  end

  desc 'Seed the database'
  task :seed do
    APP = OpenStruct.new
    APP.env = ENV['RACK_ENV']
    APP.root = Pathname.new(File.expand_path(__dir__)).freeze
    APP.config_dir = APP.root.join('config').freeze

    load(APP.root.join('db', 'seeds.rb'))
  end
end

desc 'Update model annotations'
task :annotate do
  # Load the models first
  Sequel.connect(ENV['DATABASE_URL'])
  Dir['models/*.rb'].each{|f| require_relative f}

  require 'sequel/annotate'
  Sequel::Annotate.annotate(Dir['models/*.rb'], position: :before)
end

task m: ['generate:migration:create']
task ma: ['generate:migration:alter']
