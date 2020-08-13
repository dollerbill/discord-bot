require_relative '../../models/character_action'

class CharacterAction
  module Start
    class << self
      def call(combatants)
        CharacterAction.db.transaction do
          # .order(:created_at).last ?
          return false if CharacterAction.first(complete: false)

          order = combatants.map do |c|
            names = if Character::Attack.player?(c)
                      c.name
                    else c.race
                    end
            names.join(', ') # unless c == combatants[-1]
          end
          CharacterAction.create(combatants: order)
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
