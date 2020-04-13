require_relative '../../models/stat'

class Stat
  module DiceRoll
    class << self
      def call(number, sides)
        rolls = Array.new(number) { rand(1..sides) }
        sum = rolls.reduce(:+)
        [rolls, sum]
      end

      def d20
        roll = call(1, 20)
        roll[1]
      end

      def roll_for_damage(dice, attack)
        number, sides = dice.split('d')
        roll = call(number.to_i, sides.to_i)
        roll[1] + attack.to_i
      end
    end
  end
end
