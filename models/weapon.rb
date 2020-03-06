# Table: weapons
# Columns:
#  id         | bigint                      | PRIMARY KEY DEFAULT nextval('weapons_id_seq'::regclass)
#  type       | text                        |
#  monster_id | bigint                      |
#  player_id  | bigint                      |
#  created_at | timestamp without time zone | NOT NULL DEFAULT '2020-03-05 22:11:52.256707'::timestamp without time zone
#  updated_at | timestamp without time zone | NOT NULL DEFAULT '2020-03-05 22:11:52.25671'::timestamp without time zone
# Indexes:
#  weapons_pkey                | PRIMARY KEY btree (id)
#  index_weapons_on_monster_id | btree (monster_id)
#  index_weapons_on_player_id  | btree (player_id)

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
  many_to_one :monster
  many_to_one :player
end
