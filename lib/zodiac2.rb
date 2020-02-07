require 'pry'
require_relative './scraper2.rb'


class Zodiac2
    attr_accessor :traits, :dates, :scraper2, :name, :famous_people, :how_to_spot, :secret_wish, :hates, :bad_traits, :good_traits, :favorites, :ruling_planet, :symbol, :compatibility, :mental_traits, :physical_traits, :sun_dates, :element
    
    @@all = []

    def initialize(attributes)
        attributes.each {|key, value| self.send(("#{key}="), value) if self.methods.include?("#{key}=".to_sym)}
        @@all << self
    end

    def self.create_new_zodiacs
        Scraper2.new.scrape
    end

    def self.all_dates
        self.all.map {|zodiac| zodiac.sun_dates}
    end

    def self.all_names
        self.all.map {|zodiac| zodiac.name }
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
        trait_list = trait_array.join(". ")
        trait_list
    end

    def dates 
        array_dates = self.sun_dates
        array_dates.join(' - ')
    end


end

