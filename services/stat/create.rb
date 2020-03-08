class Stat
  module Create
    MODEL_ATTS = %i[
      hp
      level
      max_hp
      monster_id
      player_id
    ].freeze

    class << self
      def call(atts)
        stats = generate_stats
        DB[:stats].insert(atts.slice(*MODEL_ATTS)).merge!(
          strength: stats[0], dexterity: stats[1], wisdom: stats[2],
          intelligence: stats[3], charisma: stats[4], constitution: stats[5]
        )
      end

      def create_monster(atts)
        atts.update(hp: 50, level: 5, max_hp: 50) unless atts[:boss].nil?
        call(atts)
      end

      def create_player(atts)
        call(atts)
      end

      private

      def generate_stats
        stats = [*1..18].sample(6) until (stats || []).inject(:+) == 75
        stats
      end
    end
  end
end
