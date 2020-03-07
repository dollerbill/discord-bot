require 'faker'

class Player
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
        DB[:players].insert(
          race: Faker::Games::DungeonsAndDragons.race,
          attack: boss ? rand(20..30) : rand(1..10),
          xp_awarded: boss ? rand(40..50) : rand(1..10)
        )
        satts = { hp: 20, level: 1 }
        Stats::Create.(satts)
        DB[:players].order(:id).last

        # monsters.insert(race: dnd.race, attack: rand(1..10),
        #                xp_awarded: rand(5..10), created_at: t, updated_at: t)
        # Monster.new(atts.slice(*MODEL_ATTS)).tap do |m|
      end
    end
  end
end
