class CommandLineInterface

    def check_birthday(input)
        #new_input = ''
        if input.include?('-')
            input = input.gsub('-', '/')
        elsif 
            input.length > 5 || input.length < 3
            return false
        end
        date = Date.parse(input)
        month = Date::MONTHNAMES[date.month]
        puts "You entered: ".blue.bold + "#{month} #{date.day}".magenta.bold + ", is that correct?".blue.bold
        user_input = gets.strip
        if user_input =~ (/[Yy](es)?/)
            return true 
        else
            return false
        end
    end

    def user_input_to_zodiac(input)
        zodiac_sign = ''
        dates = []
        Zodiac2.all_dates.each do |date_array|
            if Date.parse(input).between?(Date.parse(date_array[0]), Date.parse(date_array[1]))
                dates = date_array
            end
        end
        Zodiac2.all.each do |zodiac|
            if zodiac.sun_dates == dates
                @zodiac = zodiac
            elsif Date.parse(input).between?(Date.parse("12/22"), Date.parse("12/31")) || Date.parse(input).between?(Date.parse("01/01"), Date.parse("01/19"))
                @zodiac = Zodiac2.all.find{|zodiac| zodiac.name == "Capricorn"}
            end
        end
    @zodiac
    #binding.pry
    end

    def begin
        Zodiac2.create_new_zodiacs
        puts "Hello! Please type in your birthday (MM/DD):".blue.bold 
        user_input = gets.strip
        date = Date.parse(user_input)
        zodiac_sign = ''
        if !check_birthday(user_input)
            "Please try again: ".blue.bold
            self.begin
        else
            @zodiac = user_input_to_zodiac(user_input)
            puts "Your zodiac sign is ".blue.bold + "#{@zodiac.name}".magenta.bold
            #@zodiac = Zodiac2.all.find{|z| z.name == zodiac_sign}
        end
        zodiac_info(@zodiac)
    end


    def zodiac_info(zodiac)
        array_of_methods = ["traits", "physical_traits", "ruling_planet", "compatibility", "dates", "favorites", "symbol", "element", "famous_people", "secret_wish", "hates"]
        puts options1.blue.bold
        user_input = gets.strip 
        input = user_input.to_i
        method = array_of_methods[user_input_to_index(user_input)]
        if !input.between?(1, 7)
            puts "\n Please select a valid number:".blue.bold
            zodiac_info(@zodiac)
        elsif user_input_to_index(user_input) == 7
            puts options2.blue.bold
            user_input = gets.strip
            input = user_input.to_i
            method = array_of_methods[user_input_to_index(user_input)]
            if input.between?(1, 7)
                apply_method(method, zodiac)
            elsif !input.between?(8, 12) 
                puts "\nPlease select a valid number:".blue.bold
                zodiac_info(@zodiac)
            elsif input == 10 
                puts "\n #{method_to_string(method)}".magenta.bold + " for ".blue.bold + "#{zodiac.name}".magenta.bold  + " is:".blue.bold
                puts "\n\n #{(zodiac.send(method)).join("\n")} \n\n".magenta
                what_now(@zodiac)
            else 
                apply_method(method, zodiac)
            end
        else 
        apply_method(method, zodiac)
        end
    end

    def options1 
    <<~OPTIONS

            What would you like to know about? :

            1. Traits
            2. Physical Traits
            3. Ruling Planet
            4. Compatible signs
            5. Dates
            6. Favorite things
            7. More
        OPTIONS
    end

    def options2 
        <<~OPTIONS2
            8. Symbol
            9. Element
            10. Famous people with this sign
            11. Secret wish
            12. Hates 
        OPTIONS2
    end

    def menu 
        <<~MENU 
        What would you like to do now? \n
        1. See another zodiac sign
        2. Look at other characteristics
        3. Exit
        MENU
    end

    def apply_method(method, zodiac)
        puts "#{method_to_string(method)}".magenta.bold + " for ".blue.bold + "#{zodiac.name}".magenta.bold + " is:".blue.bold
        array = zodiac.send(method)
        puts "\n\n#{output_array_to_string(array)}\n\n ".magenta
        what_now(@zodiac)
    end

    def what_now(zodiac)
        puts menu.blue.bold
        user_input = gets.strip 
        if user_input == "2"
            zodiac_info(@zodiac)
        elsif user_input == "1"
            puts "Which sign would you like to see?".blue.bold
            Zodiac2.all_names.each_with_index {|name, index| puts "#{index+1}. #{name}".blue.bold}
            #binding.pry
            user_input_sign = gets.strip 
            #get zodiac
            user_input_index = user_input_sign.to_i - 1 
            zodiac_sign = Zodiac2.all_names[user_input_index]
            @zodiac = Zodiac2.all.find{|z| z.name == zodiac_sign}
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


    
    # #creates the list of signs that the user will select from if they select "See another zodiac sign" then "which sign would you like to see?"
    # def list_of_signs(hash)
    #     key_array = hash.keys
    #     key_array.each_with_index do |i, index|
    #         from_sym_to_str = i.to_s
    #         puts "#{index + 1}. #{from_sym_to_str}".blue.bold
    #     end
    #     key_array
    # end


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


