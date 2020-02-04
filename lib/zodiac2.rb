require 'pry'
require_relative './scraper2.rb'
#require_relative './zodiac.rb'

class Zodiac2
    attr_accessor :array_of_methods, :traits, :dates, :scraper2, :_id, :name, :__v, :famous_people, :how_to_spot, :secret_wish, :hates, :bad_traits, :good_traits, :favorites, :ruling_planet, :body_parts, :symbol, :keywords, :vibe, :compatibility, :mental_traits, :physical_traits, :sun_dates, :cardinality, :element
    @@all = []
    def initialize(attributes)
        attributes.each {|key, value| self.send(("#{key}="), value)}
        #@traits = traits
        #@dates = dates
        @@all << self
    end


    @month_to_int = {
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
    
    
    @sign_with_date_hash = {
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


    def self.create_new_zodiac(zodiac_sign)
        scraper = Scraper2.new 
        my_hash = scraper.get_page 
        attributes = scraper.parse_for_info(my_hash, zodiac_sign)
        Zodiac2.new(attributes)
    end

    def self.look_up_instance(zodiac_sign)
        Zodiac2.all.each do |i| 
            #binding.pry
            if i.name == zodiac_sign
                return i
                #   binding.pry
            end
        end

    end

        

    def self.all 
        @@all 
    end

    def self.clear 
        @@all = []
    end 
    
    def traits 
        trait_array = []
        # self.good_traits.each do |i|
        #     trait_array<< i 
        # end
        # self.bad_traits.each do |i|
        #     trait_array << i 
        # end
        # self.mental_traits.each do |i|
        #     trait_array << i 
        # end
        # self.physical_traits.each do |i|
        #     trait_array << i 
        # end
        trait_array << self.good_traits
        trait_array << self.bad_traits
        trait_array << self.mental_traits
        trait_array << self.physical_traits
        #traits_1 = trait_array[0..-1]
        trait_list = trait_array.join(". ")
        #trait_list << " #{trait_array[-1]}"
        trait_list
    end

    def dates 
        array_dates = self.sun_dates
        array_dates.join(' - ')
    end



end

