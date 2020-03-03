#require 'standalone_migrations'
#StandaloneMigrations::Tasks.load_tasks
#
require 'English'
require 'sequel'
require 'rake/testtask'

namespace :db do
  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    require "sequel/core"
    Sequel.extension :migration
    version = args[:version].to_i if args[:version]
    Sequel.connect("postgres://billy:@localhost:5432/dndiscord_development") do |db|
      Sequel::Migrator.run(db, "db/migrations", target: version)
    end
  end
end

task m: ['generate:migration:create']
task ma: ['generate:migration:alter']
