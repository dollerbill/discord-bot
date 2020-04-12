require_relative '../../config/init/configure_sequel'
require_relative '../../config/init/configure_models'

Monster.create(race: 'Wolf', attack: 5, attack_roll: '1d4', xp_awarded: 10, stat_id: 3)
Monster.create(race: 'Bugbear', attack: 25, attack_roll: '1d12', xp_awarded: 75, stat_id: 4)
