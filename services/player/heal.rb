class Player
  module Heal
    def call(player, amount)
      player.stat.set(hp: amount).save
    end

    def long_rest(players)
      players.each do |p|
        call(p, p.stat.hp_max)
        current = p.stat.hit_dice
        total = p.stat.hit_dice_max
        regained = total / 2 + current <= total ? total / 2 : total
        p.stat.set(hit_dice: regained).save
      end
    end

    def short_rest(players, hit_dice_roll)
      players.each do |p|
        rested = hit_dice_roll + p.stat.constitution
        regained = rested + p.stat.hp <= p.stat.hp_max ? rested : p.stat.hp_max
        call(p, regained)
      end
    end
  end
end
