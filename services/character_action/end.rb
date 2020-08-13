require_relative '../../models/character_action'

class CharacterAction
  module End
    class << self
      def call(combatants)
        CharacterAction.db.transaction do
          CharacterAction.first(combatants: combatants, complete: false)
                         .update(complete: true)
          Start.reset(combatants)
        end
      end
    end
  end
end
