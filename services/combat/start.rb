require_relative '../../models/combat'

class Combat
  module Start
    MSG = 'must end previous turn before proceeding.'.freeze
    class << self
      def call(combatants)
        Combat.db.transaction do
          return MSG if Combat.order(:id.asc).last(complete: false)

          order = combatants.map do |c|
            names = []
            names << if Character::Attack.player?(c)
                       c.name
                     else
                       c.race
                     end
            names.join(', ') # unless c == combatants[-1]
          end
          Combat.create(combatants: order)
          reset(combatants)
          "Combat order is #{order}"
        end
      end

      def reset(combatants)
        combatants.map do |c|
          c.stat.set(action: 1, bonus_action: 1, failure: 0, success: 0).save
          if Character::Attack.player?(c)
            c.name
          else c.race
          end
        end
      end
    end
  end
end
