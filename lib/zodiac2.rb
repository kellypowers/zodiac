require 'pry'
require_relative './scraper2.rb'


class Zodiac2
    attr_accessor :array_of_methods, :traits, :dates, :scraper2, :_id, :name, :__v, :famous_people, :how_to_spot, :secret_wish, :hates, :bad_traits, :good_traits, :favorites, :ruling_planet, :body_parts, :symbol, :keywords, :vibe, :compatibility, :mental_traits, :physical_traits, :sun_dates, :cardinality, :element
    
    @@all = []

    def initialize(attributes)
        attributes.each {|key, value| self.send(("#{key}="), value)}
        @@all << self
    end

    def self.create_new_zodiac(zodiac_sign)
        scraper = Scraper2.new 
        my_hash = scraper.get_page 
        attributes = scraper.parse_for_info(my_hash, zodiac_sign)
        Zodiac2.new(attributes)
    end

    def self.look_up_instance(zodiac_sign)
        Zodiac2.all.each do |i| 
            if i.name == zodiac_sign
                return i
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
        trait_array << self.good_traits
        trait_array << self.bad_traits
        trait_array << self.mental_traits
        trait_array << self.physical_traits
        trait_list = trait_array.join(". ")
        trait_list
    end

    def dates 
        array_dates = self.sun_dates
        array_dates.join(' - ')
    end


end

