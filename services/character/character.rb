require_relative '../../models/character_class'
require_relative '../../models/character_classes_spells'

class Character
  module Character
    ACTION_MESSAGE = ' has no remaining actions for this turn.'.freeze
    class << self
      def determine_user(attacker)
        if player?(attacker)
          attacker.name.to_s
        else
          "The #{attacker.race}"
        end
      end

      def determine_attacked(attacked)
        if player?(attacked)
          attacked.name.to_s
        else
          "The #{attacked.race}"
        end
      end
    end
  end
end
