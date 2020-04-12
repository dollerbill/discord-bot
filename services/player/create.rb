require 'faker'

class Player
  module Create
    MODEL_ATTS = %i[
      character_class
      gender
      name
      user
    ].freeze

    class << self
      def call(atts)
        die = character_atts(atts[:character_class])
        Player.create(atts.slice(*MODEL_ATTS)
                              .merge!(hit_die: die)).tap do |p|
          # .merge!(attack: rand(1..10), hit_dice: "1d#{dice}")).tap do |p|
          Stat::Create.create_player({ hit_die: die, player_id: p[:id] })
        end
      end

      def character_atts(cclass)
        case cclass.downcase
        when 'barbarian'
          12
        when 'fighter', 'paladin', 'ranger'
          10
        when 'bard', 'cleric', 'druid', 'monk', 'rogue', 'warlock'
          8
        when 'sorcerer', 'wizard'
          6
        end
      end
    end
  end
end
