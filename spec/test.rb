require 'sequel'
require_relative '../config/init/configure_sequel'
require_relative '../services/player/create'
require_relative '../services/stat/create'
require_relative '../models/player'

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
