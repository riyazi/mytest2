require 'telegram_bot'

bot = TelegramBot.new(token: '92320695:AAEd5bqGbrVUpKdUmacIWMyG1fqSyrEceEU')
bot.get_updates(fail_silently: true) do |message|
  puts "@#{message.from.username}: #{message.text}"
  command = message.get_command_for(bot)

  message.reply do |reply|
    case command
    when /greet/i
      reply.text = "Hello, #{message.from.first_name}!. i like raaamba!!!"
    when /start/i
      reply.text = "Hi, #{message.from.first_name}! valid commmands are /greet /raamba /vilares"
    when /raamba/i
      reply.text = "Raamba is so nice.. it's dark like inside my shell... and its not very far at all!!"
    when /vilares/i
      reply.text = "Vilares is dark damp coackroach infested tiny unventilated place.. but i like it there coz it's not too far away"
    else
      reply.text = "#{message.from.first_name}, have no idea what #{command.inspect} means. I probably will know that tomorrow.. or a bit later... i take some time to think about it!"
    end
    puts "sending #{reply.text.inspect} to @#{message.from.username}"
    reply.send_with(bot)
  end
end
