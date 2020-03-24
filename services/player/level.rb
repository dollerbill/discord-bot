class Player
  module Level
    class << self
      def call(players, monsters)
        @xp = 0
        monsters.each do |m|
          @xp += m.xp_awarded
        end
        players.each do |p|
          p.stat.set(experience: p.stat.experience += @xp).save

          level_up(p)
        end
        "#{players.map(&:name).join(', ')} have gained #{@xp} XP."
      end

      def level_up(player)
        p = player.stat
        xps = {
          2 => 300, 3 => 900, 4 => 2700, 5 => 6500, 6 => 14_000, 7 => 23_000, 8 => 34_000,
          9 => 48_000, 10 => 64_000, 11 => 85_000, 12 => 100_000, 13 => 120_000, 14 => 140_000,
          15 => 165_000, 16 => 195_000, 17 => 225_000, 18 => 265_000, 19 => 305_000, 20 => 355_000
        }
        xps.each do |k, v|
          p.set(level: k).save if p.experience >= v
        end
      end
    end
  end
end
