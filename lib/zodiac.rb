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
        Sagittarius: [1122, 1221],
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
    #takes the input and compares with the sign&date hash to return zodiac sign 
    def user_input_to_zodiac(input)
        if input.between?(1222, 1231) || input.between?(11, 119)
            return "Capricorn"
        elsif 
            @@sign_with_date_hash.each do |sign, date| 
                if input.between?(date[0], date[1])
                    zodiac_sign = sign.to_s
                    return zodiac_sign
                end
            end
        else
            "Please enter a valid date.".blue.bold
        end
    end
   
    #checks that the birthday is correct in the form 'February 1'
    def check_birthday(input)
        month_var = ''
        day = ''
        input_string = input.to_s
        if input_string.length <= 2 || input_string.length >= 5
            puts "Please put the date in as MMDD".blue.bold
            return false
            #go to function asking input again
        else
            @@month_to_int.each do |month, number|
                if input_string.length == 3
                    if input_string[0] == number.to_s
                        month_var = month 
                        day = "#{input_string[1]}" + "#{input_string[2]}"
                    end
                elsif input_string.length == 4
                    day = "#{input_string[2]}" + "#{input_string[3]}"
                    if input_string[0] == "0"
                        if input_string[1] == number.to_s
                        month_var = month 
                        end
                    elsif "#{input_string[0]}#{input_string[1]}" == "#{number}"
                        month_var = month
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

    def begin
        puts "Hello! Please type in your birthday (MMDD):".blue.bold 
        user_input = gets.strip
        input1 = user_input.to_i
        zodiac_sign = ''
        if !check_birthday(user_input)
            "Please try again: ".blue.bold
            self.begin
        else
            zodiac_sign = user_input_to_zodiac(input1).to_s
            puts "Your zodiac sign is #{zodiac_sign}".blue.bold
            @zodiac = Zodiac2.create_new_zodiac(zodiac_sign)
        end
        zodiac_info(@zodiac)
    end

    #is this function too long? twice it asks for user input, changes it to index, then defines method... take that out and make that it's own function?
    def zodiac_info(zodiac)
        array_of_methods = ["traits", "physical_traits", "ruling_planet", "compatibility", "dates", "favorites", "symbol", "element", "famous_people", "secret_wish", "hates"]
        puts "\nWhat would you like to know about? :
            1. Traits
            2. Physical Traits
            3. Ruling Planet
            4. Compatible signs
            5. Dates
            6. Favorite things
            7. More".blue.bold
        user_input = gets.strip 
        input = user_input.to_i
        method = array_of_methods[user_input_to_index(user_input)]
        if !input.between?(1, 7)
            puts "\n Please select a valid number:".blue.bold
            zodiac_info(@zodiac)
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
                puts "\nPlease select a valid number:".blue.bold
                zodiac_info(@zodiac)
            elsif input == 10 
                puts "\n #{method_to_string(method)} for #{@zodiac.name} is:\n".blue.bold
                puts "\n\n #{(@zodiac.send(method)).join("\n")} \n\n".blue.bold
                what_now(@zodiac)
            else 
                puts "\n #{method_to_string(method)} for #{@zodiac.name} is:\n".blue.bold
                array = @zodiac.send(method)
                puts "\n\n #{output_array_to_string(array)}\n\n ".blue.bold
                what_now(@zodiac)
            end
        else 
            puts "\n #{method_to_string(method)} for #{@zodiac.name} is:\n".blue.bold
            array = @zodiac.send(method)
            puts "\n\n #{output_array_to_string(array)}\n\n ".blue.bold
            what_now(@zodiac)
        end
    end
          
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

    def what_now(zodiac)
        puts "What would you like to do now?
                1. See another zodiac sign
                2. Look at other characteristics
                3. Exit".blue.bold
        user_input = gets.strip 
        if user_input == "2"
            zodiac_info(@zodiac)
        elsif user_input == "1"
            puts "Which sign would you like to see?".blue.bold
            hash = @@sign_with_date_hash
            list = list_of_signs(hash)
            list
            user_input_sign = gets.strip 
            @zodiac = Zodiac2.create_new_zodiac(choose_sign(user_input_sign, list))
            system "clear"
            puts "You selected #{@zodiac.name}!".blue.bold
            zodiac_info(@zodiac) 
        elsif user_input == "3"
            exit!
        elsif user_input != "1" || user_input != "2" || user_input != "3"
            puts "Please make a valid selection.".blue.bold
            what_now(@zodiac)
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
        list = list_of_signs(@@sign_with_date_hash)
        list.each_with_index do |i, index|
            if input == index 
                sign = i.to_s
            end
        end
        sign #this returns string of the zodiac sign name
    end

    def method_to_string(method)
        array = method.split('_')
        string = array.join(" ")
        string.capitalize!
    end

    def output_array_to_string(method_output)
        array = []
        string = ""
        if method_output.class == Array 
            method_output.each do |word|
                array << word.strip.capitalize 
            end
            string = array.join("\n")
        else 
            string = method_output
        end
        string
    end
end

   

    #make a method to change output of the zodiac methods, if array, join with . 

