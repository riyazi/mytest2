require 'telegram_bot'

class String
  def >> (s)
    s.prepend(self)
  end
end

bot = TelegramBot.new(token: '92320695:AAEd5bqGbrVUpKdUmacIWMyG1fqSyrEceEU')
bot.get_updates(fail_silently: true) do |message|
  puts "@#{message.from.username}: #{message.text}"
  command = message.get_command_for(bot)

  message.reply do |reply|
    case command
    when /greet/i
      reply.text = "Hello, #{message.from.first_name}!. i like raaamba!!!"
    when /start/i
      reply.text = "Hi, #{message.from.first_name}! valid commmands are /greet /raamba /vilares /sms"
    when /raamba/i
      reply.text = "Raamba is so nice.. it's dark like inside my shell... and its not very far at all!!"
    when /vilares/i
      reply.text = "Vilares is dark damp coackroach infested tiny unventilated place.. but i like it there coz it's not too far away"
    when /sms/i
	if message.text.length < 12 || message.text.length > 173
      		 reply.text = "/sms works as follows . '/sms ####### Message here(less than 160 chars)'. Check that the number is 7 digits and message length does not exceed 160 characters! "
		else		
     		  print message.text
     		  print "   -----   "
     		  numbermobile = message.text[5...12]
       	  	  
            if !/\A\d+\z/.match(numbermobile) || numbermobile.length != 7 || !numbermobile.start_with?( '9', '7')  #check if number is integers and length is correct and starts with 9 or 7
               reply.text = "umm. you didn't follow the instructions! please enter mobile number properly. '/sms ####### Message here(less than 160 chars)' "
            else
		      "960" >> numbermobile
		      message.text.slice!(0, 13)
		      messagesent = message.text
    		      message.text = message.text.gsub(/\s/,'+') #replace whitespace with + to cater for nexmo message body	
    		      print "----- final message is : "		
    		      print message.text
    		      print "   ----- number is :"
    		      print numbermobile	
    		      print ":-----   "	
		          #`curl "https://rest.nexmo.com/sms/json?api_key={KEY}&api_secret={KEY}&from=Githeyo&to=#{numbermobile}&text=#{message.text}"`
		          reply.text = "SMS '#{messagesent}' has been sent to #{numbermobile} thank you for using Githeyo bot"
            end
      end
    else
      reply.text = "#{message.from.first_name}, have no idea what #{command.inspect} means. I probably will know that tomorrow.. or a bit later... i take some time to think about it!"
    end
    puts "sending #{reply.text.inspect} to @#{message.from.username}"
    reply.send_with(bot)
  end
end
