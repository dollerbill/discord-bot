# Table: weapons
# Columns:
#  id          | bigint                      | PRIMARY KEY DEFAULT nextval('weapons_id_seq'::regclass)
#  attack      | integer                     |
#  attack_roll | text                        |
#  name        | text                        |
#  type        | text                        |
#  created_at  | timestamp without time zone | NOT NULL DEFAULT '2020-04-22 01:30:15.959451'::timestamp without time zone
#  updated_at  | timestamp without time zone | NOT NULL DEFAULT '2020-04-22 01:30:15.959455'::timestamp without time zone
# Indexes:
#  weapons_pkey | PRIMARY KEY btree (id)

require 'sequel'
require_relative '../config/init/configure_sequel'

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
  one_to_one :player
end
