require 'faker'

class Player
  module Create
    MODEL_ATTS = %i[
      alive
      attack
      race
      status
      xp_awarded
    ].freeze

    class << self
      def call(_atts)
        DB[:players].insert(
          race: Faker::Games::DungeonsAndDragons.race,
          attack: rand(1..10),
          xp_awarded: rand(1..10)
        ).tap do |p|
          Stats::Create.create_player({ hp: 10, level: 1, max_hp: 10, player_id: p })
        end
        DB[:players].order(:id).last
      end
    end
  end
end
