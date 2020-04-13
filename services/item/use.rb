require_relative '../../models/item'

class Item
  module Use
    class << self
      def call(item, target)
        return Player::Heal.(target, item.healing) if item.healing

        Attack::Attack.damage_item(item, target) if item.damage
      end
    end
  end
end
