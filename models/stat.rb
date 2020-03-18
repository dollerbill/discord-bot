# Table: stats
# Columns:
#  id           | bigint                      | PRIMARY KEY DEFAULT nextval('stats_id_seq'::regclass)
#  armor_class  | integer                     |
#  charisma     | integer                     | NOT NULL
#  constitution | integer                     | NOT NULL
#  dexterity    | integer                     | NOT NULL
#  experience   | integer                     | NOT NULL DEFAULT 1
#  hp           | integer                     | NOT NULL
#  intelligence | integer                     | NOT NULL
#  level        | integer                     | NOT NULL
#  max_hp       | integer                     | NOT NULL
#  strength     | integer                     | NOT NULL
#  wisdom       | integer                     | NOT NULL
#  status       | text                        |
#  alive        | boolean                     | NOT NULL DEFAULT true
#  created_at   | timestamp without time zone | NOT NULL DEFAULT '2020-03-17 23:22:13.331823'::timestamp without time zone
#  updated_at   | timestamp without time zone | NOT NULL DEFAULT '2020-03-17 23:22:13.331825'::timestamp without time zone
# Indexes:
#  stats_pkey | PRIMARY KEY btree (id)

class Stat < Sequel::Model
  one_to_one :monster
  one_to_one :player
end
