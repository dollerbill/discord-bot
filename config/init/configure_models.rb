# Dir['models/**/*.rb'].sort.each { |file| require_relative file }

require_relative '../../models/character_class'
require_relative '../../models/character_classes_spells'
require_relative '../../models/combat'
require_relative '../../models/item'
require_relative '../../models/monster'
require_relative '../../models/player'
require_relative '../../models/spell'
require_relative '../../models/stat'
require_relative '../../models/weapon'
