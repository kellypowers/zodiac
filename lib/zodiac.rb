require 'pry'
require_relative './scraper2.rb'
require_relative './zodiac2.rb'


class CommandLineInterface
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
    # sign_with_date_hash = {
    #     Aries: [321, 419],
    #     Taurus: [420, 520],
    #     Gemini: [521, 620],
    #     Cancer: [621, 722],
    #     Leo: [723, 822],
    #     Virgo: [823, 922],
    #     Libra: [923, 1022],
    #     Scorpio: [1023, 1121],
    #     Sagittarius: [1122, 1221],
    #     Capricorn: [1222, 119],  #watch out for this one, need exception, end of year/beginning of year
    #     Aquarius: [120, 218],
    #     Pisces: [219, 320]
    #     }
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
        "Please enter a valid date."
    end
end
#user_input_to_zodiac(sign_with_date_hash, 1116)

#checks that the birthday is correct in the form 'February 1', uses userinput(num) checks against the monthtoint data
def check_birthday(num)
    # month_to_int = {
    #     "January" => 1, 
    #     "February" => 2, 
    #     "March" => 3, 
    #     "April" => 4,
    #     "May" => 5,
    #     "June" => 6, 
    #     "July" => 7, 
    #     "August" => 8,
    #     "September" => 9,
    #     "October" => 10,
    #     "November" => 11,
    #     "December" => 12
    
    # }
    month_var =''
    day = ''
    num_string = num.to_s
    if num_string.length <= 2 || num_string.length >= 5
        puts "Please put the date in as MMDD"
        return false
        #go to function asking input again
    elsif num_string.length >= 3 
        @@month_to_int.each do |month, number|
            if num_string.length == 3
                if num_string[0] == number.to_s
                    #puts "num0 is #{num[0]} number is #{number}"
                    month_var = month 
                    day = "#{num_string[1]}" + "#{num_string[2]}"
                    #puts "length 3 day is #{day} month is #{month_var}"
                end
            elsif num_string.length == 4
                if num_string[0] == "0"
                    if num_string[1] == "number"
                    month_var = month 
                    day = "#{num_string[2]}" + "#{num_string[3]}"
                    end
                elsif "#{num_string[0]}#{num_string[1]}" == "#{number}"
                    #puts "num01 is #{num[0]}#{num[1]} number is #{number}"
                    month_var = month
                    day = "#{num_string[2]}" + "#{num_string[3]}"
                    #puts "length 4 day is #{day} month is #{month_var}"
                end
            end
        end
    end
    puts "Your entered #{month_var} #{day}. Is this correct? Y/N "
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




    # def input_to_int(user_input1)
    #      user_input1.to_i
    # end



    def start
        puts "Hello! Please type in your birthday (MMDD): "
        user_input = gets.strip
        input1 = user_input.to_i
        zodiac_sign = ''
        zodiac = ''
        if !check_birthday(user_input)
            "Please try again: "
            self.start
        else
            zodiac_sign = user_input_to_zodiac(input1)
            puts "Your zodiac sign is #{zodiac_sign}"
            zodiac = Zodiac2.create_new_zodiac(zodiac_sign.to_s)
        end
        #zodiac = Zodiac2.look_up_instance(zodiac_sign)
        #binding.pry
        self.zodiac_info(zodiac_sign)
        i = 0
        while i < 10 do #some other condition, just testing this out
        #self.zodiac_info(zodiac_sign)
        self.what_now(zodiac_sign) #this should loop so you can select all the things, if i do give me more info about it, it stops
        i += 1 
        end
    end

    def zodiac_info(zodiac_sign)
         zodiac = Zodiac2.look_up_instance(zodiac_sign) #why does this return an array?? messed up cause when redirected from what now, it is not an array, goes no further
         #zodiac = zodiac1[0]
        array_of_methods = ["traits", "symbol", "ruling_planet", "compatibility", "dates", "how_to_spot", "symbol", "element", "famous_people", "secret_wish", "hates"]
        puts "What do you want to know about:
        1.  Traits
        2.  Symbol
        3.  Ruling Planet
        4.  Compatible signs
        5.  Dates
        6.  How to spot this sign
        7. More"
        user_input = gets.strip 
        input = user_input.to_i
        method = array_of_methods[user_input_to_index(user_input)]
        if !input.between?(1, 7)
            puts "Please select a valid number:"
            zodiac_info(zodiac_sign)
        elsif user_input_to_index(user_input) == 7
            puts "
            8. Symbol
            9. Element
            10. Famous people with this sign
            11. Secret wish
            12. Hates"
            user_input = gets.strip
            input = user_input.to_i
            method = array_of_methods[user_input_to_index(user_input)]
            if !input.between?(8, 12)
                puts "Please select a valid number:"
                zodiac_info(zodiac_sign)
            else 
                #method = array_of_methods[user_input_to_index]
                puts "\n\n #{zodiac.send(method)}\n\n "
            end
        else 
            #binding.pry
           puts "\n\n #{zodiac.send(method)} \n\n"
            
        end
    end
#after changing signs, i can what do you want to know about good, then what do you want to know about again bad. 
    
            
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

        
    # def valid?(num1, num2)
    #     if user_input.to_i.between?(num1, num2)
    #         true
    #     else
    #         false
    #     end
    # end
    # def zodiac_methods
    #     puts "What would you like to see? : \n1. Traits \n2. "
    
    def what_now(zodiac_sign)
        zodiac = Zodiac2.look_up_instance(zodiac_sign) #why does this return an array??
        #zodiac = zodiac1[0]
        #binding.pry
        puts " What would you like to do now?
        1. See another zodiac sign
        2. Look at other characteristics
        3. Exit"
        user_input = gets.strip 
        # if user_input != "1" || user_input != "2" || user_input != "3"
        #     puts "Please make a valid selection."
        #     what_now(zodiac.name)
        if user_input == "2"
            zodiac_info(zodiac.name)
        elsif user_input == "1"
            Zodiac2.clear
            puts "Which sign would you like to see?"
            hash = @@sign_with_date_hash
            list = list_of_signs(hash)
            list
            user_input_sign = gets.strip 
            #choose_sign(user_input_sign, list_of_signs(sign_with_date_hash))
            zodiac = Zodiac2.create_new_zodiac(choose_sign(user_input_sign, list))
            #what_now(zodiac.name)
            zodiac_info(zodiac.name) #this returns an array for zodiac, not the object wen it was just zodiac in the argument
        elsif user_input == "3"
            exit!
        end
    end




    def list_of_signs(sign_with_date_hash)
        key_array = sign_with_date_hash.keys
        key_array.each_with_index do |i, index|
            from_sym_to_str = i.to_s
            puts "#{index + 1}. #{from_sym_to_str}"
        end
        key_array
    end

    ##pisces how to spot freezes bc of double quotes
    #10 give hates not famous people  9 gives secret with, not element
    #when going from what now to you want to know about another zodiac sign, select the sign, does not register as the object..hates gave ...,   ..array?
    #from look at other characteristics after choosing sign choose sign it comes up as array

    def choose_sign(input, array)
        sign = ''
        input = input.to_i - 1 
        list = list_of_signs(@@sign_with_date_hash)
        list.each_with_index do |i, index|
            if input == index 
                sign = i.to_s
            end
        end
        sign
    end




end