# Table: spells
# Columns:
#  id            | bigint  | PRIMARY KEY DEFAULT nextval('spells_id_seq'::regclass)
#  level         | integer | NOT NULL
#  name          | text    | NOT NULL
#  casting_time  | text    | NOT NULL
#  description   | text    | NOT NULL
#  duration      | text    | NOT NULL
#  higher_levels | text    |
#  range         | text    | NOT NULL
#  type          | text    | NOT NULL
#  components    | text    | NOT NULL
# Indexes:
#  spells_pkey | PRIMARY KEY btree (id)
# Referenced By:
#  character_classes_spells | character_classes_spells_spell_id_fkey | (spell_id) REFERENCES spells(id)

require 'sequel'
require_relative '../config/init/configure_sequel'

class Spell < Sequel::Model
  many_to_many :character_classes,
               join_table: :character_classes_spells,
               left_key: :spell_id,
               right_key: :character_class_id
end
