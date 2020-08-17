Toil.register(:weapon, ->(*args) { Weapon.create(*args) }) do
  attack { rand(1..20) }
  name %w[knife dagger sword bow net axe javelin].sample
end
