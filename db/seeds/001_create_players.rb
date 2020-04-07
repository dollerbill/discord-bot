require_relative '../../config/init/configure_sequel'
require_relative '../../config/init/configure_models'

Weapon.create(name: 'Dagger', type: 'melee', attack: 3, attack_roll: '1d4')
Weapon.create(name: 'Bow', type: 'ranged', attack: 4, attack_roll: '1d6')
Stat.create(level: 1, hp: 10, hp_max: 10, strength: 12, dexterity: 12, wisdom: 12,
            intelligence: 12, charisma: 12, constitution: 12, armor_class: 10)
Stat.create(level: 1, hp: 10, hp_max: 10, strength: 12, dexterity: 12, wisdom: 12,
            intelligence: 12, charisma: 12, constitution: 12, armor_class: 10)
Stat.create(level: 1, hp: 10, hp_max: 10, strength: 12, dexterity: 12, wisdom: 12,
            intelligence: 12, charisma: 12, constitution: 12, armor_class: 10)
Stat.create(level: 5, hp: 75, hp_max: 75, strength: 12, dexterity: 12, wisdom: 12,
            intelligence: 12, charisma: 12, constitution: 12, armor_class: 10)
Player.create(name: 'Dungeon Master', character_class: 'Unknown', gender: 'none', hit_die: 1)
Player.create(name: 'Bilbo', character_class: 'Paladin', hit_die: 10, gender: 'male', user: 'dollerbill', stat_id: 1, weapon_id: 1)
Player.create(name: 'Junebug', character_class: 'Rogue', hit_die: 8, gender: 'male', stat_id: 2, weapon_id: 1)
Monster.create(race: 'Wolf', attack: 5, attack_roll: '1d4', xp_awarded: 10, stat_id: 3)
Monster.create(race: 'Bugbear', attack: 25, attack_roll: '1d12', xp_awarded: 75, stat_id: 4)
