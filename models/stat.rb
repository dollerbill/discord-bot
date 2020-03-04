class Stat < Sequel::Model
  many_to_one :monster
  many_to_one :player
end