require 'dotenv/load'
require 'discordrb'
require 'faker'
require 'pg'
require 'sequel'
require_relative 'config/init/configure_sequel'

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

bot.command(:create_player, description: 'creates a new player character',
                            usage: 'create player', min_args: 4) do |event, n, g, c, a|
  next 'Invalid syntax... try: `create_player Bob, male, Paladin, 5`' unless
      n && g && c && (at = Integer(a, 10))

  atts = { name: n, gender: g, character_class: c, attack: at,
           alignment: dnd.alignment, background: dnd.background,
           created_at: t, updated_at: t, user: event.user.name }
  players = DB[:players]
  player = players.insert(
    atts
    # name: n, gender: g, character_class: c, attack: at, created_at: t, updated_at: t
  )
  event << players.order(:created_at).last
end

bot.command(:create_monster, description: 'hi',
                             usage: 'monster') do |event|
  monsters = DB[:monsters]
  monsters.insert(name: dnd.name, alive: true, race: dnd.race, attack: rand(1..10),
                  xp_awarded: rand(5..10), created_at: t, updated_at: t)
  monster = monsters.order(:created_at).last
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
                       usage: 'monstermash') do |event|
  event << '**All known monsters:**'
  event << '`Goblin. 10 HP, 5 ATK`'
  event << '`Owlbear. 20 HP, 12 ATK`'
  event << DB[:monsters].all.map { |m| "#{m[:name]}, #{m[:alive]}" }
end

bot.command(:weapons, description: 'lists all weapons',
                      usage: '+monsters') do |event|
  event << DB[:weapons].all.map { |w| w[:name] }
end

bot.message(content: 'dice') do |event|
  event.respond 'how many dice'
end

bot.mention do |event|
  event.user.pm("You are #{event.user.name}!")
  event.respond "Hey #{event.user.name}"
end

# bot.message do |e|
#  e.respond "It is #{e.timestamp}"
# end

bot.run
