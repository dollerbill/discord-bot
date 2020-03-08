require 'dotenv/load'
require 'discordrb'
require 'faker'
require 'pg'
require 'sequel'
require_relative 'config/init/configure_sequel'
require_relative 'services/monster/create'

dnd = Faker::Games::DungeonsAndDragons
bot = Discordrb::Commands::CommandBot.new(token: ENV['TOKEN'], prefix: '+')
t = Time.now

bot.command(:roll, description: 'rolls some dice',
                   usage: 'roll 2d6', min_args: 1) do |event, dice|
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
  rolls = Array.new(number) { rand(1..sides) }
  sum = rolls.reduce(:+)

  # Return the result
  "#{event.user.name} rolled: `#{rolls}`, total: `#{sum}`"
end

bot.command(:attack, description: 'attacks a monster',
                     usage: '+attack monster weapon', min_args: 2) do |event, monster, weapon|
  event << "You attack #{monster} with #{weapon} for #{rand(1..10)} damage"
end

bot.command(:check_player, description: 'shows player stats',
usage: '+check player') do |event|
  p = DB[:players].where(user: event.user.name).first
  event << "Player #{p[:name]} - Current HP: #{p[:hp]}. Max HP: #{p[:max_hp]}. Ailments: #{p[:status] || 'none'}"

bot.command(:create_player, description: 'creates a new player character',
                            usage: '+create player', min_args: 4) do |event, n, g, c, a|
  next 'Invalid syntax... try: `create_player Bob, male, Paladin, 5`' unless
      n && g && c && (at = Integer(a, 10))

  atts = { name: n, gender: g, character_class: c, attack: at,
           alignment: dnd.alignment, background: dnd.background,
           created_at: t, updated_at: t, user: event.user.name }
  Player::Create.(atts)
  event << players.order(:created_at).last
end

bot.command(:create_monster, description: 'hi',
                             usage: 'monster') do |event, boss|
  monster = Monster::Create.(boss)
  event << "A #{monster[:race]} appears!"
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
                       usage: '+monsters') do |event|
  # event << '**All known monsters:**'
  alive = DB[:monsters].where(alive: true)
  names = alive.map { |m| m[:name] }
  if alive.count == 0
    event << 'You see no monsters in the area.'
  elsif alive.count == 1
    event << "You see a #{alive.first[:name]}!"
  else
    msg = "You're surrounded by "
    names.each_with_index do |m, i|
      msg += if i == names.length - 1
               "and a #{m}!"
             else
               "a #{m}, "
        end
    end
    event << msg
  end

  # event << DB[:monsters].where(alive: true).map { |m| m[:name] }
end

bot.command(:test) do |e|
  # e << dnd.race
  # e << dnd.character_class
  Monster::Create.()
end

# bot.command(:weapons, description: 'lists all weapons',
#                      usage: '+monsters') do |event|
#  event << DB[:weapons].all.map { |w| w[:name] }
# end
#
# bot.message(content: 'dice') do |event|
#  event.respond 'how many dice'
# end

bot.mention do |event|
  event.user.pm("You are #{event.user.name}!")
  event.respond "Hey #{event.user.name}"
end

bot.run
