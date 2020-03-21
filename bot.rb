require 'dotenv/load'
require 'discordrb'
require 'faker'
# require 'pg'
require_relative 'Rakefile'
require 'sequel'
require_relative 'config/init/configure_sequel'
require_relative 'config/init/configure_models'
Dir['services/**/*.rb'].each { |file| require_relative file }

dnd = Faker::Games::DungeonsAndDragons
bot = Discordrb::Commands::CommandBot.new(token: ENV['TOKEN'], prefix: '+')
t = Time.now

# DM ONLY

# TODO: make attack, etc DM only? have player roll and DM calls
bot.command(:attack, description: 'attacks a monster using your attack roll',
                     usage: '+attack Wolf Dagger 12', min_args: 3) do |e, enemy, weapon, hit|
  # next 'Only the DM can perform this action!' unless e.user.name == Player[1].user

  player = Player.find(user: e.user.name)
  monster = Monster.first(race: enemy)
  weapon = Weapon.first(name: weapon)

  next "There is no #{enemy} to attack." unless monster.stat.alive

  hit_roll = Integer(hit, 10)
  e << Attack::Attack.(player, monster, hit_roll, weapon)
end

bot.command(:monster_attack, description: 'attacks a monster',
                             usage: '+attack monster weapon', min_args: 2) do |e, monster, name|
  # next 'Only the DM can attack for monsters!' unless e.user.name == Player[1].user

  player = Player.find(name: name)
  monster = Monster.first(race: monster)
  next "#{name} is already dead and can't be attacked." unless player.stat.alive

  hit_roll = Stat::DiceRoll.d20
  e << Attack::Attack.(monster, player, hit_roll, nil)
end

bot.command(:start_game, description: 'Begins a new game',
                         usage: '+start_game') do |e|
  Rake::Task['db:reset'].reenable
  Rake::Task['db:reset'].invoke
  e << 'You enter a dark and gloomy forrest...'
end

bot.command(:save_throw, description: 'Makes a save throw',
                         usage: '+save throw Urth 10') do |_e, _name, roll|
  # next 'Only the DM can attack for monsters!' unless e.user.name == Player[1].user

  save_throw = Integer(roll, 10)
  Player::SaveThrow.(player, save_throw)
end

bot.command(:create_monster, description: 'hi',
                             usage: 'monster') do |event, boss|
  monster = Monster::Create.(boss)
  event << "A #{monster[:race]} appears!"
end

# PLAYER METHODS

bot.command(:create_player, description: 'creates a new player character',
                            usage: '+create player', min_args: 4) do |event, n, g, c, a|
  next 'Invalid syntax... try: `create_player Bob, male, Paladin, 5`' unless
      n && g && c && (at = Integer(a, 10))

  atts = { name: n, gender: g, character_class: c, attack: at,
           alignment: dnd.alignment, background: dnd.background,
           created_at: t, updated_at: t, user: event.user.name }
  p = Player::Create.(atts)
  event << "#{p[:name]}, level: #{p.stat[:level]}, current hp: #{p.stat[:hp]}/#{p.stat[:max_hp]}"
end

bot.command(:help, aliases: [:h], description: 'list all game commands',
                   usage: 'help') do |event|
  event << '**All available commands:**'
  event << '`+attack monster weapon: "Attacks a monster with a weapon' \
           '(ex: +attack Owlbear crossbow)"`'
  event << '`+game: "Starts a new game of dnd"`'
  event << '`+help: "Lists all game commands"`'
  event << '`+roll xdn: "Rolls x number of n sided dice (ex: +roll 2d5)"`'
  event << '`+monsters: Lists all monsters in the bestiary`'
  event << '`+create_monster: Creates a new monster`'
  event << '`+create_player: Creates a new player character`'
  event << '`+players: Lists all active players`'
end

bot.command(:monsters, description: 'lists all monsters in the bestiary',
                       usage: '+monsters') do |e|
  # event << '**All known monsters:**'
  alive = Monster.where(alive: true)
  names = alive.map { |m| m[:name] }
  if alive.count == 0
    e << 'You see no monsters in the area.'
  elsif alive.count == 1
    e << "You see a #{alive.first[:name]}!"
  else
    msg = "You're surrounded by "
    names.each_with_index do |m, i|
      msg += if i == names.length - 1
               "and a #{m}!"
             else
               "a #{m}, "
             end
    end
    e << msg
  end
end

bot.command(:roll, description: 'rolls some dice',
                   usage: 'roll 2d6', min_args: 1) do |e, dice|
  # Parse the input
  number, sides = dice.split('d')

  # Check for valid input; make sure we got both numbers
  next 'Invalid syntax.. try: `roll 2d10`' unless number && sides

  # Check for valid input; make sure we actually got numbers and not words
  begin
    number = Integer(number, 10)
    sides  = Integer(sides, 10)
  rescue ArgumentError
    next 'You must pass two *numbers*.. try: `roll 2d10`'
  end

  # Time to roll the dice!
  rolled = Stat::DiceRoll.(number, sides)

  # Return the result
  "#{e.user.name} rolled: `#{rolled[0]}`, total: `#{rolled[1]}`"
end

bot.command(:stats, description: 'shows player stats',
                    usage: '+stats') do |e|
  p = Player.find(user: event.user.name)
  msg = "Player: #{p.name}. Level: #{p.stat.level}. HP: #{p.stat.hp}/#{p.stat.max_hp}. "\
      "Status: #{p[:status] || 'Healthy'}"
  e << msg
end

bot.command(:test) do |_e|
  # e << dnd.race
  Player[1].name # Attack::Attack.determine_attacker(Monster.first)
end

bot.command(:weapons, description: 'lists all weapons',
                      usage: '+monsters') do |event|
  event << DB[:weapons].all.map { |w| w[:name] }
end

bot.command(:use_weapon)
#
# bot.message(content: 'dice') do |event|
#  event.respond 'how many dice'
# end

bot.mention do |event|
  event.user.pm("You are #{event.user.name}!")
  event.respond "Hey #{event.user.name}"
end

bot.run
