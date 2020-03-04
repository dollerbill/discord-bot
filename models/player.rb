class Player < Sequel::Model
  one_to_one :stat
  one_to_one :weapon
end