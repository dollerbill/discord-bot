# Table: character_classes_spells
# Primary Key: (character_class_id, spell_id)
# Columns:
#  character_class_id | bigint |
#  spell_id           | bigint |
# Indexes:
#  character_classes_spells_pkey | PRIMARY KEY btree (character_class_id, spell_id)
# Foreign key constraints:
#  character_classes_spells_character_class_id_fkey | (character_class_id) REFERENCES character_classes(id)
#  character_classes_spells_spell_id_fkey           | (spell_id) REFERENCES spells(id)

require 'sequel'
require_relative '../config/init/configure_sequel'

class CharacterClassesSpells < Sequel::Model
  unrestrict_primary_key

  one_to_many :character_classes, key: %i[character_class_id spell_id]
  one_to_many :spells, key: %i[character_class_id spell_id]
end
