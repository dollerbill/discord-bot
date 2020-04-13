require_relative '../../services/stat/dice_roll'

class Attack
  module Attack
    class << self
      def call(attacker, attacked, hit_roll, weapon)
        name = determine_attacker(attacker)
        if hit_roll == 1
          "1! #{name} missed their attack by a mile."
        elsif hit_roll == 20
          msg = deal_damage(attacked, determine_damage(attacker, weapon))
          "Critical hit! #{msg}"
        else
          hit_roll += modifier(attacker)
          return "#{name} misses their attack!" unless hit_roll >= attacked.stat.armor_class

          dmg = determine_damage(attacker, weapon)
          deal_damage(attacked, dmg)
        end
      end

      private

      def damage_item(item, target)
        dice, extra = item.damage.split('+')
        extra ||= 0
        damage = Stat::DiceRoll.roll_for_damage(dice, extra)
        deal_damage(target, damage)
      end

      def damage_monster(attacked)
        attacked.stat.set(alive: false, hp: 0).save
        "#{determined_attacked(attacked)} was killed!"
      end

      def damage_player(attacked)
        attacked.stat.set(unconscious: true, hp: 0).save
        "#{determined_attacked(attacked)} is knocked unconscious!"
      end

      def deal_damage(attacked, damage)
        if attacked.stat.hp > damage
          attacked.stat.this.update(hp: :hp - damage)
          "#{determined_attacked(attacked)} takes #{damage} points of damage!"
        else
          msg = damage_player(attacked) if player?(attacked)
          msg = damage_monster(attacked) unless player?(attacked)
          msg
        end
      end

      def determine_attacker(attacker)
        if player?(attacker)
          attacker.name.to_s
        else
          "The #{attacker.race}"
        end
      end

      def determined_attacked(attacked)
        if player?(attacked)
          attacked.name.to_s
        else
          "The #{attacked.race}"
        end
      end

      def determine_damage(attacker, weapon)
        if player?(attacker)
          attack = weapon.attack
          dice = weapon.attack_roll
        else
          attack = attacker.attack
          dice = attacker.attack_roll
        end
        Stat::DiceRoll.roll_for_damage(dice, attack)
      end

      def modifier(player)
        return 0 unless player?(player)

        case player.weapon.type
        when 'ranged'
          player.stat.strength
        when 'melee'
          player.stat.dexterity
        end
      end

      def player?(player)
        player.is_a?(Player)
      end
    end
  end
end
