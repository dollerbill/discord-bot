# Table: monsters
# Columns:
#  id          | bigint                      | PRIMARY KEY DEFAULT nextval('monsters_id_seq'::regclass)
#  attack      | integer                     | NOT NULL
#  xp_awarded  | integer                     | NOT NULL
#  attack_roll | text                        |
#  race        | text                        | NOT NULL
#  stat_id     | bigint                      |
#  created_at  | timestamp without time zone | NOT NULL DEFAULT '2020-04-07 00:39:30.228253'::timestamp without time zone
#  updated_at  | timestamp without time zone | NOT NULL DEFAULT '2020-04-07 00:39:30.228256'::timestamp without time zone
# Indexes:
#  monsters_pkey             | PRIMARY KEY btree (id)
#  index_monsters_on_stat_id | btree (stat_id)

class Monster < Sequel::Model
  many_to_one :stat
end
