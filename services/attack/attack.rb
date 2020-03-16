class Attack
  module Attack
    class << self
      def call(attacker, attackee)
        i = Stat::DiceRoll.d20
        return 'Missed!' if i == 1

        return determine_damage(attacker, attackee) if i == 20

        modifier = modifier(attacker) if attacker.is_a?(Player)
        total = i + (modifier || 0)
        return 'less than AC' unless total >= attackee.armor_class

        determine_damage(attacker, attackee)
      end

      def determine_damage(attacker, attackee)
        attack = attacker.weapon.attack || attacker.attack
        dice = attacker.weapon.attack_roll || attacker.attack_roll
        dmg = Stat::DiceRoll.roll_for_damage(dice, attack)
        deal_damage(attackee, dmg)
      end

      def deal_damage(attackee, damage)
        if attackee.stat.hp > damage
          attackee.stat.update(hp: attackee.stat.hp - damage)
        else
          attackee.stat.set(alive: false, hp: 0).save
        end
      end

      def modifier(player)
        case player.weapon.type
        when 'ranged'
          player.stat.strength
        when 'melee'
          player.stat.dexterity
        end
      end
    end
  end
end
