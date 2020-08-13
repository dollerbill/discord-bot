require_relative '../../config/init/configure_sequel'
require_relative '../../config/init/configure_models'

weapons = File.read('public/data/weapons.json')
wep = JSON.parse(weapons)

wep.each do |w|
  c      = w['cost']
  d      = w['Damage'].split(' ')[0]
  d_type = w['Damage'].split(' ')[1]&.capitalize
  n      = w['Name']
  p      = w['Properties']
  r      = w['Properties'].join(', ').match(%r{\d{2}/\d{2}})&.send(:[], 0)
  w      = w['Weight']
  w_type = w['Weapon_type']

  Weapon.create(
    cost: c, range: r, name: n, weight: w, properties: p, damage: d, damage_type: d_type, weapon_type: w_type
  )
end
