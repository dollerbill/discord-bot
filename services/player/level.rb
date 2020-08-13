require_relative '../../models/player'

class Player
  module Level
    class << self
      def call(players, monsters)
        xp = calculate_xp(players, monsters)
        players.each do |p|
          p.stat.set(experience: :experience + xp).save

          level_up(p)
        end
        "#{players.map(&:name).join(', ')} have gained #{xp} XP."
      end

      def calculate_xp(players, monsters)
        @xp = 0
        monsters.each do |m|
          @xp += m.xp_awarded
        end
        @xp *= modifier(monsters)
        @xp /= players.count
        @xp.round
      end

      def level_up(player)
        p = player.stat
        xps = {
          2 => 300, 3 => 900, 4 => 2700, 5 => 6500, 6 => 14_000, 7 => 23_000, 8 => 34_000,
          9 => 48_000, 10 => 64_000, 11 => 85_000, 12 => 100_000, 13 => 120_000, 14 => 140_000,
          15 => 165_000, 16 => 195_000, 17 => 225_000, 18 => 265_000, 19 => 305_000, 20 => 355_000
        }
        xps.each do |k, v|
          p.set(level: k).save && player.set(hit_dice: k, hit_dice_max: k).save if p.experience >= v
        end
      end

      def mods(monsters)
        case monsters.count
        when 1
          1
        when 2
          1.5
        when 3, 4, 5, 6
          2
        when 7, 8, 9, 10
          2.5
        when 11, 12, 13, 14
          3
        else
          4
        end
      end

      def modifier(monsters)
        mod = if monsters.count == 1
                1
              elsif monsters.count == 2
                1.5
              elsif monsters.count < 7
                2
              elsif monsters.count < 11
                2.5
              elsif monsters.count < 15
                3
              else
                4
              end
        mod
      end
    end
  end
end
