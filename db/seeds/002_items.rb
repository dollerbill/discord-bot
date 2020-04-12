require_relative '../../config/init/configure_sequel'
require_relative '../../config/init/configure_models'

Item.create(name: 'Potion of Healing', healing: '2d4+2')
Item.create(name: 'Potion of Greater Healing', healing: '4d4+4')
Item.create(name: 'Potion of Superior Healing', healing: '8d4+8')
Item.create(name: 'Potion of Supreme Healing', healing: '10d4+20')
Item.create(name: 'Basic Poison', damage: '1d4')