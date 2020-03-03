DB = Sequel.connect(ENV['DATABASE_URL'])

Sequel.extension :core_extensions
Sequel.extension :core_refinements
Sequel.extension :migration
Sequel.extension :pg_array
Sequel.extension :pg_array_ops
Sequel.extension :error_sql

Sequel::Model.plugin :boolean_readers
