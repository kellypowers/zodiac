require 'pry'
require 'colorize'
require_relative './scraper2.rb'
require_relative './zodiac2.rb'


class CommandLineInterface

    #these hashes will be used in later functions to create/display info
    @@sign_with_date_hash = {
        Aries: [321, 419],
        Taurus: [420, 520],
        Gemini: [521, 620],
        Cancer: [621, 722],
        Leo: [723, 822],
        Virgo: [823, 922],
        Libra: [923, 1022],
        Scorpio: [1023, 1121],
        Sagittarius: [1222, 1221],
        Capricorn: [1222, 119],  #watch out for this one, need exception, end of year/beginning of year
        Aquarius: [120, 218],
        Pisces: [219, 320]
        }

     @@month_to_int = {
        "January" => 1, 
        "February" => 2, 
        "March" => 3, 
        "April" => 4,
        "May" => 5,
        "June" => 6, 
        "July" => 7, 
        "August" => 8,
        "September" => 9,
        "October" => 10,
        "November" => 11,
        "December" => 12
        }

#takes the input(num) and compares with the sign&date hash to return zodiac sign 
def user_input_to_zodiac(num)
    if num.between?(1222, 1231) || num.between?(11, 119)
        return "Capricorn"
    elsif 
        @@sign_with_date_hash.each do |key, i| 
            if num.between?(i[0], i[1])
                key1 = key.to_s
                #puts "Your zodiac sign is #{key1}"
                return key1 
            end
        end
    else
        "Please enter a valid date.".blue.bold
    end
end
#user_input_to_zodiac(sign_with_date_hash, 1116)

#checks that the birthday is correct in the form 'February 1', uses userinput(num) checks against the monthtoint data
def check_birthday(num)
    month_var =''
    day = ''
    num_string = num.to_s
    if num_string.length <= 2 || num_string.length >= 5
        puts "Please put the date in as MMDD".blue.bold
        return false
        #go to function asking input again
    elsif num_string.length >= 3 
        @@month_to_int.each do |month, number|
            if num_string.length == 3
                if num_string[0] == number.to_s
                    month_var = month 
                    day = "#{num_string[1]}" + "#{num_string[2]}"
                end
            elsif num_string.length == 4
                if num_string[0] == "0"
                    if num_string[1] == "number"
                    month_var = month 
                    day = "#{num_string[2]}" + "#{num_string[3]}"
                    end
                elsif "#{num_string[0]}#{num_string[1]}" == "#{number}"
                    month_var = month
                    day = "#{num_string[2]}" + "#{num_string[3]}"
                end
            end
        end
    end
    puts "Your entered #{month_var} #{day}. Is this correct? Y/N ".blue.bold
    input = gets.strip
    if input =~ (/[Yy](es)?/)
        return true
    else
        return false
    #if no, ask for input again and then ru this function again
    end
end
#check_birthday(1116, month_to_int)
#after birthday is verified, give zodiac, then ask if they want to see their traits, give traits.




    def start
        puts "Hello! Please type in your birthday (MMDD): ".blue.bold
        user_input = gets.strip
        input1 = user_input.to_i
        zodiac_sign = ''
        zodiac = ''
        if !check_birthday(user_input)
            "Please try again: ".blue.bold
            self.start
        else
            zodiac_sign = user_input_to_zodiac(input1)
            puts "Your zodiac sign is #{zodiac_sign}".blue.bold
            zodiac = Zodiac2.create_new_zodiac(zodiac_sign.to_s)
        end
        self.zodiac_info(zodiac_sign)
        i = 0
        while i < 10 do #some other condition, just testing this out
        #self.zodiac_info(zodiac_sign)
        self.what_now(zodiac_sign) #this should loop so you can select all the things, if i do give me more info about it, it stops
        i += 1 
        end
    end

    #is this function too long? twice it asks for user input, changes it to index, then defines method... take that out and make that it's own function?
    def zodiac_info(zodiac_sign)
         zodiac = Zodiac2.look_up_instance(zodiac_sign) #why does this return an array?? messed up cause when redirected from what now, it is not an array, goes no further
         #zodiac = zodiac1[0]
        array_of_methods = ["traits", "physical_traits", "ruling_planet", "compatibility", "dates", "favorites", "symbol", "element", "famous_people", "secret_wish", "hates"]
        puts "What do you want to know about:
        1.  Traits
        2.  Physical Traits
        3.  Ruling Planet
        4.  Compatible signs
        5.  Dates
        6. Favorite things
        7. More".blue.bold
        user_input = gets.strip 
        input = user_input.to_i
        method = array_of_methods[user_input_to_index(user_input)]
        if !input.between?(1, 7)
            puts "Please select a valid number:".blue.bold
            zodiac_info(zodiac_sign)
        elsif user_input_to_index(user_input) == 7
            puts "
            8. Symbol
            9. Element
            10. Famous people with this sign
            11. Secret wish
            12. Hates".blue.bold
            user_input = gets.strip
            input = user_input.to_i
            method = array_of_methods[user_input_to_index(user_input)]
            if !input.between?(8, 12)
                puts "Please select a valid number:".blue.bold
                zodiac_info(zodiac_sign)
            else 
                puts "\n #{method} for #{zodiac.name} is:\n".blue.bold
                puts "\n\n #{zodiac.send(method)}\n\n ".blue.bold
            end
        else 
            puts "\n #{method} for #{zodiac.name} is:\n".blue.bold
            puts "\n\n #{zodiac.send(method)} \n\n".blue.bold
            
        end
    end
    
#after changing signs, the 'what do you want to know about' is good, then 'what do you want to know about' again second time is bad. 
    
            
    def user_input_to_index(input)
        input = input.to_i
        index = 0
        if input.between?(1, 6)
            index = input - 1 
        elsif input.between?(8, 12)
            index = input - 2 
        elsif input == 7
            index = 7
        end
        index
    end

    def what_now(zodiac_sign)
        zodiac = Zodiac2.look_up_instance(zodiac_sign) #why does this return an array after looping??
        puts "What would you like to do now?
                1. See another zodiac sign
                2. Look at other characteristics
                3. Exit".blue.bold
        user_input = gets.strip 
        if user_input == "2"
            zodiac_info(zodiac.name)
            #binding.pry this zodiac is not an array
        elsif user_input == "1"
            Zodiac2.clear
            puts "Which sign would you like to see?".blue.bold
            hash = @@sign_with_date_hash
            list = list_of_signs(hash)
            list
            user_input_sign = gets.strip 
            zodiac = Zodiac2.create_new_zodiac(choose_sign(user_input_sign, list))
            puts "You selected #{zodiac.name}!".blue.bold
            #what_now(zodiac.name)
            zodiac_info(zodiac.name) #this returns an array for zodiac, not the object wen it was just zodiac in the argument
            #binding.pry  so the return is NOT an array, but if you get back to 'what would you like to do now' and select 2 look at other traits, it says it is an array.
        elsif user_input == "3"
            exit!
        elsif user_input != "1" || user_input != "2" || user_input != "3"
            puts "Please make a valid selection.".blue.bold
            what_now(zodiac.name)
        end
    end



    #creates the list of signs that the user will select from if they select "See another zodiac sign" then "which sign would you like to see?"
    def list_of_signs(sign_with_date_hash)
        key_array = sign_with_date_hash.keys
        key_array.each_with_index do |i, index|
            from_sym_to_str = i.to_s
            puts "#{index + 1}. #{from_sym_to_str}".blue.bold
        end
        key_array
    end


    #takes user input, compares to array of signs, returns the sign
    def choose_sign(input, array)
        sign = ''
        input = input.to_i - 1 
        #list = [:Aries, :Taurus, :Gemini, :Cancer, :Leo, :Virgo, :Libra, :Scorpio, :Sagittarius, :Capricorn, :Aquarius, :Pisces] 
        list = list_of_signs(@@sign_with_date_hash)
        list.each_with_index do |i, index|
            if input == index 
                sign = i.to_s
            end
        end
        sign #this returns string of the zodiac sign name
    end

    ###check this function to see return value is not an array
end

    #bugs:
    ##pisces 'how to spot' freezes bc of double quotes

    #when going from what now to you want to know about another zodiac sign, select the sign, does not register as the object..hates gave ...,   ..array?
    #from look at other characteristics after choosing sign choose sign it comes up as array
    #possible solutions for bugs: 
    #bring the loop to the beginning instead of linking back to it several times throughout.
    #when you want to look at another zodiac sign, link this to begining
    #take out the greeting put it somewhere else? in the bin file maybe
    #or, after looking at new zodiac sign, exit out of it.

    #make a method to change method to a string with capital letter and no _ so it can be outputted nicely.

    