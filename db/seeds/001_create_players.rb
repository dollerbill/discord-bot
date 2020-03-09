require_relative '../../config/init/configure_sequel'
require_relative '../../config/init/configure_models'

Player.create(name: 'Bilbo', character_class: 'Paladin', gender: 'male', attack: 6, user: 'dollerbill')
Player.create(name: 'Junebug', character_class: 'Rogue', gender: 'male', attack: 4)
Monster.create(race: 'Wolf', attack: 5, xp_awarded: 10)
Monster.create(race: 'Bugbear', attack: 25, xp_awarded: 75)
Stat.create(level: 1, hp: 10, max_hp: 10, strength: 12, dexterity: 12, wisdom: 12,
            intelligence: 12, charisma: 12, constitution: 12, player_id: 1)
Stat.create(level: 1, hp: 10, max_hp: 10, strength: 12, dexterity: 12, wisdom: 12,
            intelligence: 12, charisma: 12, constitution: 12, player_id: 2)
Stat.create(level: 1, hp: 10, max_hp: 10, strength: 12, dexterity: 12, wisdom: 12,
            intelligence: 12, charisma: 12, constitution: 12, monster_id: 1)
Stat.create(level: 5, hp: 75, max_hp: 75, strength: 12, dexterity: 12, wisdom: 12,
            intelligence: 12, charisma: 12, constitution: 12, monster_id: 2)
