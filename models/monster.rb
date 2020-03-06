# Table: monsters
# Columns:
#  id         | bigint                      | PRIMARY KEY DEFAULT nextval('monsters_id_seq'::regclass)
#  race       | text                        | NOT NULL
#  status     | text                        |
#  alive      | boolean                     | NOT NULL DEFAULT true
#  attack     | integer                     | NOT NULL
#  xp_awarded | integer                     | NOT NULL
#  created_at | timestamp without time zone | NOT NULL DEFAULT '2020-03-05 22:11:52.246102'::timestamp without time zone
#  updated_at | timestamp without time zone | NOT NULL DEFAULT '2020-03-05 22:11:52.246105'::timestamp without time zone
# Indexes:
#  monsters_pkey | PRIMARY KEY btree (id)

class Monster < Sequel::Model
  one_to_one :stat
end
