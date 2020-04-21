class Character
  module Character
    ACTION_MESSAGE = ' has no remaining actions for this turn.'.freeze

    def determine_attacker(attacker)
      if player?(attacker)
        attacker.name.to_s
      else
        "The #{attacker.race}"
      end
    end

    def determined_attacked(attacked)
      if player?(attacked)
        attacked.name.to_s
      else
        "The #{attacked.race}"
      end
    end
  end
end
