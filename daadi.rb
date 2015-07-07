require 'telegram_bot'

bot = TelegramBot.new(token: 'YOURTOKENHERE')
bot.get_updates(fail_silently: true) do |message|
  puts "@#{message.from.username}: #{message.text}"
  command = message.get_command_for(bot)

  message.reply do |reply|
    case command
    when /greet/i
      reply.text = "Hello, #{message.from.first_name}!. Is it time to change fb relationship status?"
    when /start/i
      reply.text = "Hi, #{message.from.first_name}! I respond to /greet /single and /relationship"
    when /single/i
      reply.text = "Daadi's fb relationship status may be hidden but it is also single. Nothing to do here, moving on..."
    when /relationship/i
      reply.text = "Changing Daadi's fb relationship status......FAILURE! Please retry with less active interests"
    when /rau/i
      reply.text = "Hang in there, Rau! The status will change when the time is right"

    else
      reply.text = "#{message.from.first_name}, have no idea what #{command.inspect} means. I can just try to change Daadi's fb relationship status"
    end
    puts "sending #{reply.text.inspect} to @#{message.from.username}"
    reply.send_with(bot)
  end
end