# Table: stats
# Columns:
#  id           | bigint                      | PRIMARY KEY DEFAULT nextval('stats_id_seq'::regclass)
#  level        | integer                     | NOT NULL
#  hp           | integer                     | NOT NULL
#  max_hp       | integer                     | NOT NULL
#  strength     | integer                     | NOT NULL
#  dexterity    | integer                     | NOT NULL
#  constitution | integer                     | NOT NULL
#  intelligence | integer                     | NOT NULL
#  wisdom       | integer                     | NOT NULL
#  charisma     | integer                     | NOT NULL
#  monster_id   | bigint                      |
#  player_id    | bigint                      |
#  created_at   | timestamp without time zone | NOT NULL DEFAULT '2020-03-05 22:11:52.252517'::timestamp without time zone
#  updated_at   | timestamp without time zone | NOT NULL DEFAULT '2020-03-05 22:11:52.25252'::timestamp without time zone
# Indexes:
#  stats_pkey                | PRIMARY KEY btree (id)
#  index_stats_on_monster_id | btree (monster_id)
#  index_stats_on_player_id  | btree (player_id)

class Stat < Sequel::Model
  many_to_one :monster
  many_to_one :player
end
