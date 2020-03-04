Sequel::Model.plugin :dirty
Sequel.extension :core_extensions
Sequel.extension :core_refinements
Sequel.extension :migration
Sequel.extension :pg_array
Sequel.extension :pg_array_ops
Sequel.extension :error_sql

Sequel::Model.plugin :association_pks
Sequel::Model.plugin :boolean_readers
Sequel::Model.plugin :many_through_many

using Sequel::CoreRefinements

class Weapon < Sequel::Model
  many_to_one :player
end