require 'faker'

class Player
  module Create
    MODEL_ATTS = %i[
      character_class
      gender
      name
      user
    ].freeze

    class << self
      def call(atts)
        Player.create(atts.slice(*MODEL_ATTS)
                              .merge!(attack: rand(1..10))).tap do |p|
          Stat::Create.create_player({ hp: 10, level: 1, max_hp: 10, player_id: p[:id] })
        end
      end
    end
  end
end
