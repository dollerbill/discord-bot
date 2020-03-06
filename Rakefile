require 'sequel'
require 'rake/testtask'

namespace :db do
  desc 'Run migrations'
  task :migrate, [:version] do |t, args|
    require 'sequel/core'
    Sequel.extension :migration
    version = args[:version].to_i if args[:version]
    Sequel.connect('postgres://billy:@localhost:5432/dndiscord_development') do |db|
      Sequel::Migrator.run(db, 'db/migrations', target: version)
    end
  end
end

desc 'Update model annotations'
task :annotate do
  # Load the models first
  Sequel.connect('postgres://billy:@localhost:5432/dndiscord_development')
  Dir['models/*.rb'].each{|f| require_relative f}

  require 'sequel/annotate'
  Sequel::Annotate.annotate(Dir['models/*.rb'], position: :before)
end


task m: ['generate:migration:create']
task ma: ['generate:migration:alter']
