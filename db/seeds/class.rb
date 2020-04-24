require_relative '../../config/init/configure_sequel'
require_relative '../../config/init/configure_models'

classes = %w[barbarian bard cleric druid fighter monk
             paladin ranger rogue sorcerer warlock wizard]
classes.each do |c|
  CharacterClass.create(name: c)
end
