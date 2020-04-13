require_relative '../../models/player'

class Player
  module Heal
    class << self
      def call(player, amount)
        ps = player.stat
        hp = amount + ps.hp
        regained = hp <= ps.hp_max ? hp : ps.hp_max
        ps.set(hp: regained).save
        "#{player.name} now has #{regained} hp."
      end

      def healing_item(item, target)
        dice, extra = item.healing.split('+')
        extra ||= 0
        heal = Stat::DiceRoll.roll_for_damage(dice, extra)

        call(target, heal)
      end

      def long_rest(players)
        players.each do |p|
          call(p, p.stat.hp_max)
          current = p.hit_dice
          total = p.hit_dice_max
          regained = (total / 2).floor + current <= total ? (total / 2).floor : total
          regained = regained == 0 ? 1 : regained
          p.set(hit_dice: regained).save
          return "#{p.name} now has #{p.stat.hp} hp and #{p.hit_dice} hit dice."
        end
      end

      def short_rest(player, hit_dice_roll)
        msg = "#{player.name} has no available hit dice and cannot take a short rest."
        return msg if player.hit_dice == 0

        player.set(hit_dice: :hit_dice - 1).save
        rested = hit_dice_roll + player.stat.constitution
        regained = rested + player.stat.hp <= player.stat.hp_max ? rested : player.stat.hp_max
        call(player, regained)
        "#{player.name} now has #{player.stat.hp} hp and #{player.hit_dice} hit dice."
      end
    end
  end
end
