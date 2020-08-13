require 'pry'
require 'sequel'
# require_relative '../config/init/configure_sequel'
# require_relative '../services/character/character'
# require_relative '../services/player/create'
# require_relative '../services/stat/create'
# require_relative '../models/monster'
# require_relative '../models/player'

describe Player::Create do
  context 'given player attributes' do
    it 'should create a character' do
      atts = {
        character_class: 'rogue',
        gender: 'female',
        name: 'freida',
        user: 'Jona',
        hit_dice: 1,
        hit_dice_max: 1
      }
      player = Player::Create.(atts)
      expect(player.name).to eq 'freida'
      expect(player.user).to eq 'Jona'
    end
  end
end

describe Character::Character do
  let(:monster) { Monster.create(race: 'Wolf', attack: 5, attack_roll: '1d4', xp_awarded: 10, stat_id: 3) }
  let(:player) do
    Player.create(
      character_class: 'rogue',
      gender: 'female',
      name: 'freida',
      user: 'Jona',
      hit_die: Player::Create.character_atts('rogue'),
      hit_dice: 1,
      hit_dice_max: 1
    )
  end
  describe '.determine_user' do
    context 'when given a player' do
      it 'returns player name' do
        Toil.create(:weapon)
        binding.pry
        expect(Character::Character.determine_user(player)).to eq('freida')
      end
    end

    context 'when given a monster' do
      it 'returns the monsters race' do
        expect(Character::Character.determine_user(monster)).to eq('The Wolf')
      end
    end
  end

  describe '.determine_attacked' do
    context 'when given a player' do
      it 'returns player name' do
        expect(Character::Character.determine_user(player)).to eq('freida')
      end
    end

    context 'when given a monster' do
      it 'returns the monsters race' do
        expect(Character::Character.determine_user(monster)).to eq('The Wolf')
      end
    end
  end
end
