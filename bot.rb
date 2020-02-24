require 'dotenv/load'
require 'discordrb'

bot = Discordrb::Commands::CommandBot.new(token: ENV['TOKEN'], prefix: '+')

bot.command(:roll, description: 'rolls some dice',
            usage: 'roll 2d6', min_args: 1) do |_event, dice|
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
  "You rolled: `#{rolls}`, total: `#{sum}`"
end

bot.command(:attack, description: 'attack a monster',
            usage: 'he attac', min_args: 2) do |event, monster, weapon|
  event << "You attack #{monster} with #{weapon} for #{rand(1..10)} damage"
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
  event << '`+players: Lists all active players`'
end

bot.command(:monsters, description: 'lists all monsters in the bestiary',
            usage: 'monstermash') do |event|
  event << '**All known monsters:**'
  event << '`Goblin. 10 HP, 5 ATK`'
  event << '`Owlbear. 20 HP, 12 ATK`'
end

bot.message(content: 'dice') do |event|
  event.respond 'how many dice'
end

bot.mention do |event|
  event.user.pm("You are #{event.user.name}!")
  event.respond "Hey #{event.user.name}"
end

#bot.message do |e|
#  e.respond "It is #{e.timestamp}"
#end

bot.run
