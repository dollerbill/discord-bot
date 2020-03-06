# Table: players
# Columns:
#  id              | bigint                      | PRIMARY KEY DEFAULT nextval('players_id_seq'::regclass)
#  name            | text                        | NOT NULL
#  user            | text                        |
#  gender          | text                        | NOT NULL
#  character_class | text                        | NOT NULL
#  status          | text                        |
#  alignment       | text                        |
#  background      | text                        |
#  attack          | integer                     | NOT NULL
#  experience      | integer                     | NOT NULL DEFAULT 1
#  created_at      | timestamp without time zone | NOT NULL DEFAULT '2020-03-05 22:11:52.249332'::timestamp without time zone
#  updated_at      | timestamp without time zone | NOT NULL DEFAULT '2020-03-05 22:11:52.249334'::timestamp without time zone
# Indexes:
#  players_pkey | PRIMARY KEY btree (id)

class Player < Sequel::Model
  # extend DSL::Enums

  # enum :status, %w[Blinded Charmed Deafened Frightened Grappled Incapacitated
  #                 Invisible Paralyzed Petrified Poisoned Prone Restrained
  #                 Stunned Unconscious]

  one_to_one :stat
  one_to_one :weapon
end
