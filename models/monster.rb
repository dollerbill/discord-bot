class Monster < Sequel::Model
  one_to_one :stat
end