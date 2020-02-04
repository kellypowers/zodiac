require 'pry'

month_to_int = {
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

# sign_with_date_hash = {
#     #"Gemini"
# Aries: [[321], [419]]
# Taurus: [[4, 20], [5, 20]
# Gemini: [[5, 21], [6, 20]
# Cancer: [[6, 21], [7, 22]
# Leo: [[7, 23], [8, 22]
# Virgo: [[8, 23], [9, 22]]
# Libra: [[9, 23], [10, 22]]
# Scorpio: [[10, 23], [11, 21]]
# Sagittarius: [12, 22], [12, 21]]
# Capricorn: [[12, 22], [1, 19]]  #watch out for this one, need exception, end of year/beginning of year
# Aquarius: [[1, 20], [2, 18]]
# Pisces: [[2, 19], [3, 20]]
# }
sign_with_date_hash = {
    #"Gemini"
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


def user_input_to_zodiac(sign_with_date_hash, num)
    if num.between?(1222, 1231) || num.between?(11, 119)
        return "Gemini"
    elsif 
        sign_with_date_hash.each do |key, i| 
            if num.between?(i[0], i[1])
                key1 = key.to_s
                puts "Your zodiac sign is #{key1}"
                return key 
            end
        end
    else
        "Please enter a valid date."
    end
end
user_input_to_zodiac(sign_with_date_hash, 1116)


def check_birthday(num, month_to_int)
    month_var =''
    day = ''
    num_string = num.to_s
    if num_string.length <= 2 || num_string.length >= 5
        puts "Please put the date in as MMDD"
        return false
        #go to function asking for input again
    elsif num_string.length >= 3
        month_to_int.each do |month, number|
            if num_string.length == 3
                if num_string[0] == number.to_s
                    puts "num0 is #{num[0]} number is #{number}"
                    month_var = month 
                    day = "#{num_string[1]}" + "#{num_string[2]}"
                    puts "length 3 day is #{day} month is #{month_var}"
                end
            elsif num_string.length == 4
                if "#{num_string[0]}#{num_string[1]}" == "#{number}"
                    puts "num01 is #{num[0]}#{num[1]} number is #{number}"
                    month_var = month
                    day = "#{num_string[2]}" + "#{num_string[3]}"
                    puts "length 4 day is #{day} month is #{month_var}"
                end
            end
        end
    end
    puts "Your entered #{month_var} #{day}. Is this correct? Y/N "
    input = gets.strip
    if input == (/[Yy](es)?/)
        return true
    else
        return false
    #if no, ask for input again and then ru this function again
end
end
check_birthday(1116, month_to_int)
#after birthday is verified, give zodiac, then ask if they want to see their traits, give traits.



