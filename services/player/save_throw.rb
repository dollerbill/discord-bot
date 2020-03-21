class Attack
  module SaveThrow
    class << self
      def call(player, save_throw)
        if save_throw == 1
          failing_throw(player, 2)
        elsif save_throw == 20
          stabilize(player)
        elsif save_throw > 9
          saving_throw(player)
        else
          failing_throw(player)
        end

        death(player) if player.stat.failure > 2
        stabilize(player) if player.stat.success == 3
        "#{player.name} has #{player.stat.success} successes and #{player.stat.failure} failures."
      end

      def reset(player)
        player.stat.set(failure: 0, success: 0).save
      end

      private

      def death(player)
        player.stat.set(alive: false).save
        "#{player.name} has died."
      end

      def failing_throw(player, num = 1)
        player.stat.set(failure: player.stat.failure += num)
      end

      def stabilize(player)
        player.stat.set(hp: 1, success: 0, failure: 0, unconscious: false).save
        "#{player.name} has gained 1 HP."
      end

      def saving_throw(player)
        player.stat.set(success: player.stat.success += 1)
      end
    end
  end
end
