require_relative '../../config/init/configure_sequel'
require_relative '../../config/init/configure_models'

Weapon.create(name: 'Dagger', type: 'melee', attack: 3, attack_roll: '1d4')
Weapon.create(name: 'Bow', type: 'ranged', attack: 4, attack_roll: '1d6')
