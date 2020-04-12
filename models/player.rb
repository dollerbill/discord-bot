# Table: players
# Columns:
#  id              | bigint                      | PRIMARY KEY DEFAULT nextval('players_id_seq'::regclass)
#  alignment       | text                        |
#  background      | text                        |
#  character_class | text                        | NOT NULL
#  gender          | text                        | NOT NULL
#  name            | text                        | NOT NULL
#  user            | text                        |
#  hit_die         | integer                     | NOT NULL
#  hit_dice        | integer                     | NOT NULL DEFAULT 1
#  hit_dice_max    | integer                     | NOT NULL DEFAULT 1
#  stat_id         | bigint                      |
#  weapon_id       | bigint                      |
#  created_at      | timestamp without time zone | NOT NULL DEFAULT '2020-04-07 00:39:30.243046'::timestamp without time zone
#  updated_at      | timestamp without time zone | NOT NULL DEFAULT '2020-04-07 00:39:30.243049'::timestamp without time zone
# Indexes:
#  players_pkey               | PRIMARY KEY btree (id)
#  index_players_on_stat_id   | btree (stat_id)
#  index_players_on_weapon_id | btree (weapon_id)

require 'sequel'
require_relative '../config/init/configure_sequel'

# Table: players
# Columns:
#  id              | bigint                      | PRIMARY KEY DEFAULT nextval('players_id_seq'::regclass)
#  alignment       | text                        |
#  background      | text                        |
#  character_class | text                        | NOT NULL
#  gender          | text                        | NOT NULL
#  name            | text                        | NOT NULL
#  user            | text                        |
#  hit_die         | integer                     | NOT NULL
#  hit_dice        | integer                     | NOT NULL DEFAULT 1
#  stat_id         | bigint                      |
#  weapon_id       | bigint                      |
#  created_at      | timestamp without time zone | NOT NULL DEFAULT '2020-04-05 23:59:33.347715'::timestamp without time zone
#  updated_at      | timestamp without time zone | NOT NULL DEFAULT '2020-04-05 23:59:33.347717'::timestamp without time zone
# Indexes:
#  players_pkey               | PRIMARY KEY btree (id)
#  index_players_on_stat_id   | btree (stat_id)
#  index_players_on_weapon_id | btree (weapon_id)

class Player < Sequel::Model
  # extend DSL::Enums

  # enum :status, %w[Blinded Charmed Deafened Frightened Grappled Incapacitated
  #                 Invisible Paralyzed Petrified Poisoned Prone Restrained
  #                 Stunned Unconscious]

  many_to_one :stat
  many_to_one :weapon
end
