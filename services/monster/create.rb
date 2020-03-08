require 'faker'

class Monster
  module Create
    MODEL_ATTS = %i[
      alive
      attack
      boss
      race
      status
      xp_awarded
    ].freeze

    class << self
      def call(boss)
        monster = DB[:monsters].insert(
          race: Faker::Games::DungeonsAndDragons.race,
          attack: boss ? rand(20..30) : rand(1..10),
          xp_awarded: boss ? rand(40..50) : rand(1..10)
        )
        Stat::Create.create_monster({ hp: 10, level: 1, max_hp: 10, monster_id: monster })
        DB[:monsters].order(:id).last
      end

      def 
    end
  end
end
