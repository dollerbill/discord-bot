require 'dotenv/load'
require 'discordrb'

bot = Discordrb::Bot.new token: ENV['TOKEN']

bot.message(content: 'hi') do |event|
  event.respond 'Little Chrissy is so silly!'
end

bot.mention do |event|
  event.user.pm("You are #{event.user.name}!")
  event.respond "Hey #{event.user.name}"
end

bot.run
