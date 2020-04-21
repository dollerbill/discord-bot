# TODO: should encounters be preset? only necessary monsters, items, etc ready to go?
# TODO: should all monsters, items, etc be present in DB and DM can use when necessary?

require_relative 'config/environment'

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

bot.command(:award_items, description: 'award items after battle',
                          usage: '+award_items ') do |e, player, items|
end

bot.command(:award_xp, description: 'award xp after battle',
                       usage: '+ award_xp player,player monster,monster') do |e, player_list, monster_list|
  players = Array(player_list.split(','))
  next 'no players' unless players.each { |p| Player.first(name: p) }

  monsters = Array(monster_list.split(','))
  next 'no monsters' unless monsters.each { |m| Monster.first(race: m) }

  players.map! { |p| Player.find(name: p) }
  monsters.map! { |p| Monster.find(race: p) }
  e << Player::Level.(players, monsters)
end

bot.command(:long_rest, description: 'provides a long rest',
                        usage: '+long_rest player,player,player ') do |e, player_list|
  players = Array(player_list.split(','))
  next 'no players' unless players.each { |p| Player.first(name: p) }

  players.map! { |p| Player.find(name: p) }
  e << Player::Heal.long_rest(players)
end

bot.command(:list_monsters, description: 'lists all monsters in the bestiary',
                            usage: '+list_monsters') do |e|
  Monster.all.each do |m|
    e << "#{m.race}, #{m.id}"
  end
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
# TODO
bot.command(:create_monster, description: 'hi',
                             usage: 'monster') do |event, boss|
  monster = Monster::Create.(boss)
  event << "A #{monster[:race]} appears!"
end

# PLAYER METHODS

bot.command(:create_player, description: 'creates a new player character',
                            usage: '+create_player', min_args: 3) do |event, n, g, c|
  next 'Invalid syntax... try: `+create_player Bob male Paladin`' if
      (n + g + c).include?(',')

  atts = { name: n, gender: g, character_class: c,
           alignment: dnd.alignment, background: dnd.background,
           created_at: t, updated_at: t, user: event.user.name }
  p = Player::Create.(atts)
  event << atts
  event << "#{p[:name]}, level: #{p.stat[:level]}, current hp: #{p.stat[:hp]}/#{p.stat[:hp_max]}"
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
  alive = Monster.stat.where(alive: true)
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
                   usage: '+roll 2d6', min_args: 1) do |e, dice|
  # Parse the input
  number, sides = dice.split('d')

  # Check for valid input; make sure we got both numbers
  next 'Invalid syntax.. try: `+roll 2d10`' unless number && sides

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

bot.command(:short_rest, description: 'provides a player a short rest',
                         usage: '+short_rest 6 ') do |e, p, roll|
  p = Player.find(name: p)
  roll = Integer(roll, 10)
  next 'incorrect hit dice roll' unless roll <= p.hit_die

  e << Player::Heal.short_rest(p, roll)
end

bot.command(:stats, description: 'shows player stats',
                    usage: '+stats') do |e|
  p = Player.find(user: e.user.name)
  msg = "Player: #{p.name}. Level: #{p.stat.level}. HP: #{p.stat.hp}/#{p.stat.hp_max}. "\
      "Status: #{p[:status] || 'Healthy'}"
  e << msg
end

bot.command(:test) do |_e|
  # Player::Level.([Player[3], Player[2]], [Monster[1], Monster[2]]) # e << dnd.race
  # e << Player::Heal.long_rest([Player[2], Player[3]])
  Attack::SaveThrow.(Player[2], 1)
end

bot.command(:weapons, description: 'lists all weapons',
                      usage: '+monsters') do |event|
  event << DB[:weapons].all.map { |w| w[:name] }
end

bot.command(:use_item, description: 'uses an item',
                       usage: '+use_item potion_of_healing Tarvin') do |e, item, target|
  target = Player.first(name: target) || Player.first(user: e.user.name)
  e << Item::Use.(item, target)
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
