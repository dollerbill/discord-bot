# Table: players
# Columns:
#  id              | bigint                      | PRIMARY KEY DEFAULT nextval('players_id_seq'::regclass)
#  alignment       | text                        |
#  background      | text                        |
#  character_class | text                        | NOT NULL
#  gender          | text                        | NOT NULL
#  name            | text                        | NOT NULL
#  user            | text                        |
#  stat_id         | bigint                      |
#  weapon_id       | bigint                      |
#  created_at      | timestamp without time zone | NOT NULL DEFAULT '2020-03-15 23:42:16.29263'::timestamp without time zone
#  updated_at      | timestamp without time zone | NOT NULL DEFAULT '2020-03-15 23:42:16.292633'::timestamp without time zone
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
