# Table: character_classes
# Columns:
#  id   | bigint | PRIMARY KEY DEFAULT nextval('character_classes_id_seq'::regclass)
#  name | text   | NOT NULL
# Indexes:
#  character_classes_pkey | PRIMARY KEY btree (id)
# Referenced By:
#  character_classes_spells | character_classes_spells_character_class_id_fkey | (character_class_id) REFERENCES character_classes(id)

require 'sequel'
require_relative '../config/init/configure_sequel'

class CharacterClass < Sequel::Model
  many_to_many :spells,
               join_table: :character_classes_spells,
               left_key: :character_class_id,
               right_key: :spell_id
end
