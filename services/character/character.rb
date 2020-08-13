# require_relative '../../models/character_class'
# require_relative '../../models/character_classes_spells'
require_relative './attack'

class Character
  module Character
    # TODO: move into charactions?
    ACTION_MESSAGE = ' has no remaining actions for this turn.'.freeze
    class << self
      # TODO: combine into one method?
      def determine_user(attacker)
        if Attack.player?(attacker)
          attacker.name.to_s
        else
          "The #{attacker.race}"
        end
      end

      def determine_attacked(attacked)
        if Attack.player?(attacked)
          attacked.name.to_s
        else
          "The #{attacked.race}"
        end
      end
    end
  end
end
