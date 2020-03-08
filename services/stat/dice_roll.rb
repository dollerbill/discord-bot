class Stat
  module DiceRoll
    class << self
      def call(number, sides)
        rolls = Array.new(number) { rand(1..sides) }
        sum = rolls.reduce(:+)
        "rolled: `#{rolls}`, total: `#{sum}`"
      end

      def roll_initiative
        call(1, 20)
      end
    end
  end
end
