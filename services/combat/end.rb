require_relative '../../models/combat'

class Combat
  module End
    class << self
      def call(combatants)
        Combat.db.transaction do
          Combat.first(combatants: combatants, complete: false)
                .update(complete: true)
          Start.reset(combatants)
        end
      end
    end
  end
end
