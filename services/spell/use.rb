require_relative '../../models/spell'
# TODO: spell::attack? attack::spell?
class Spell
  module Use
    ACTION_MESSAGE = ' has no remaining actions for this turn.'.freeze
    BARBARIAN_MSG = 'Barbarians cannot use magic'.freeze
    SPELL_SLOT_MSG = 'does not have a spell to cast'.freeze
    SUBCLASS_MSG = 'magic'.freeze
    class << self
      def call(user, used_on, spell)
        user.model.db.transaction do
          name = Character::Character.determine_user(user)
          no_spell(user)

          case spell.type
          when 'healing'
            Player::Heal.(used_on)
          when 'damage'
            Character::Attack.(user, used_on, spell.dmg)
          end
        end
      end

      def no_spell(user)
        return name + Character::Character::ACTION_MESSAGE if user.stat.action == 0

        return BARBARIAN_MSG if player.character_class.downcase == 'barbarian'
        return SUBCLASS_MSG if %w[fighter monk rogue].include?(player.character_class.downcase)
        return SPELL_SLOT_MSG if player.spell_slot[spell.level.to_i] == 0
      end
    end
  end
end
