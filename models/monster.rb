# Table: monsters
# Columns:
#  id          | bigint                      | PRIMARY KEY DEFAULT nextval('monsters_id_seq'::regclass)
#  attack      | integer                     | NOT NULL
#  xp_awarded  | integer                     | NOT NULL
#  attack_roll | text                        |
#  race        | text                        | NOT NULL
#  stat_id     | bigint                      |
#  created_at  | timestamp without time zone | NOT NULL DEFAULT '2020-04-22 01:30:15.940974'::timestamp without time zone
#  updated_at  | timestamp without time zone | NOT NULL DEFAULT '2020-04-22 01:30:15.940978'::timestamp without time zone
# Indexes:
#  monsters_pkey             | PRIMARY KEY btree (id)
#  index_monsters_on_stat_id | btree (stat_id)

require 'sequel'
require_relative '../config/init/configure_sequel'

class Monster < Sequel::Model
  many_to_one :stat
end
