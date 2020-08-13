Toil.register(:player, ->(*args) { Player.create(*args) }) do
  name { Faker::Games::DnD.name }
  alignment { Faker::Games::DnD.alignment }
  race { Faker::Games::DnD.race }
  character_class { Faker::Games::DnD.klass }
  hit_die do
    Player::Create.character_atts(character_class)
  end
end
