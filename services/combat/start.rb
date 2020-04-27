class Combat
  module Start
    class << self
      def call(combatants)
        order = combatants.map do |c|
          c.stat.set(action: 1, bonus_action: 1, failure: 0, success: 0).save
          if Character::Attack.player?(c)
            c.name
          else c.race
          end
        end
        "Combat order is #{order.join(', ')}"
      end
    end
  end
end
