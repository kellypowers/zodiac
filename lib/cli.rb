require 'pry'
class CommandLineInterface

    def begin
        Zodiac.create_new_zodiacs
        puts "Hello! Please type in your birthday (MM/DD):".blue.bold 
        user_input = gets.strip
        zodiac_sign = ''
        if !check_birthday(user_input)
            "Please try again: ".blue.bold
            self.begin
        else
            @zodiac = user_input_to_zodiac(user_input) #set as instance variable so it can be passed to other instance methods
            puts "Your zodiac sign is ".blue.bold + "#{@zodiac.name}".magenta.bold
        end
        zodiac_info(@zodiac)
    end

    #an input of MM-DD throws an error on Date object, replaces a hyphen with a backslash, checks the input is valid.  Asks the user if their birthday is in the form "February 9". 
    def check_birthday(input)
        if input.include?('-')
            input = input.gsub('-', '/')
        elsif 
            input.length > 5 || input.length < 3
            return false
        end
        date = Date.parse(input)
        month = Date::MONTHNAMES[date.month] #uses built in class constant to select the name of the month based on the number input
        puts "You entered: ".blue.bold + "#{month} #{date.day}".magenta.bold + ", is that correct? Y/N".blue.bold
        user_input = gets.strip
        user_input =~ (/[Yy](es)?/) ? true : false
    end

    #takes the user inputted DOB, serches through the dates in all Zodiac instances using the Date object, returns the zodiac instance. Exception made for Capricorn because beginning of year /end of year
    def user_input_to_zodiac(input)
        zodiac_sign = ''
        dates = []
        Zodiac.all_dates.each do |date_array|
            if Date.parse(input).between?(Date.parse(date_array[0]), Date.parse(date_array[1]))
                dates = date_array
            end
        end
        Zodiac.all.each do |zodiac|
            if zodiac.sun_dates == dates
                @zodiac = zodiac
            elsif Date.parse(input).between?(Date.parse("12/22"), Date.parse("12/31")) || Date.parse(input).between?(Date.parse("01/01"), Date.parse("01/19"))
                @zodiac = Zodiac.all.find{|zodiac| zodiac.name == "Capricorn"}
            end
        end
    @zodiac
    end

    #gives options of what characteristics of zodiac you would like to see, and displays it, asks for user selection.  Selected from array_of methods and the selected method is applied to the zodiac instance.
    def zodiac_info(zodiac)
        array_of_methods = Zodiac.get_attributes.map{|attribute| attribute.to_s}
        puts options1.blue.bold
        user_input = gets.strip.to_i
        method = array_of_methods[user_input]
        if !user_input.between?(1, 7)
            puts "\n Please select a valid number:".blue.bold
            zodiac_info(@zodiac)
        elsif user_input == 7
            user_select_7(user_input, @zodiac, array_of_methods)
        else 
        apply_method(method, zodiac)
        end
    end

    #method if user selects "More" from options1, so it can loop back around if 7 is selected multiple times and index 7 is never actually selected
    def user_select_7(input, zodiac, array_of_methods)
        puts options2.blue.bold
        user_input = gets.strip.to_i
        method = array_of_methods[user_input]
        if user_input.between?(1, 6)
            apply_method(method, zodiac)
        elsif !user_input.between?(8, 12) 
            puts "\nPlease select a valid number:".blue.bold
            zodiac_info(@zodiac)
        elsif user_input == 10  #exception for famous_people method because the capitalization should be kept as it was originally.
            puts "\n #{method_to_string(method)}".magenta.bold + " who also have ".blue.bold + "#{zodiac.name}".magenta.bold  + "sign :".blue.bold
            puts "\n\n #{(zodiac.send(method)).join("\n")} \n\n".magenta
            what_now(@zodiac)
        elsif user_input == 7
            user_select_7(input, array_of_methods)
        else 
            apply_method(method, zodiac)
        end
    end

    #heredoc to normalize the spacing
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

    #used to reduce repeating the code, called twice in zodiac_info method
    def apply_method(method, zodiac)
        puts "\n#{method_to_string(method)}".magenta.bold + " for ".blue.bold + "#{zodiac.name}".magenta.bold + " is/are:".blue.bold
        method_output = zodiac.send(method)
        puts "\n\n#{output_array_to_string(method_output)}\n\n ".magenta
        what_now(@zodiac)
    end
    
    #what now gives the "what would you like to do now" menu, gives list of zodiac signs, takes user input and returns what the user requested to see
    def what_now(zodiac)
        puts menu.blue.bold
        user_input = gets.strip 
        if user_input == "2"
            zodiac_info(@zodiac)
        elsif user_input == "1"
            puts "Which sign would you like to see?".blue.bold
            Zodiac.all_names.each_with_index {|name, index| puts "#{index + 1}. #{name}".blue.bold}
            user_input_sign = gets.strip 
            user_input_index = user_input_sign.to_i - 1 
            zodiac_sign = Zodiac.all_names[user_input_index]
            @zodiac = Zodiac.all.find{|z| z.name == zodiac_sign}
            system "clear"
            puts "You selected ".blue.bold + "#{@zodiac.name}".magenta.bold + "!".blue.bold
            zodiac_info(@zodiac) 
        elsif user_input == "3"
            exit!
        elsif user_input != "1" || user_input != "2" || user_input != "3"
            puts "Please make a valid selection.".blue.bold
            what_now(@zodiac)
        end
    end

    #this takes the method and returns it to tell the user what they are looking at on on line 74 and in the apply_method method.
    def method_to_string(method)
        method = method.to_s
        array = method.split('_')
        string = array.join(" ")
        string.capitalize!
    end

    #this takes the return value from the zodiac instance method and if it is an array, changes to capitalize firt word and separate wtih a new line
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


