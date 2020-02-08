
class Zodiac
    @@attributes = [:name, :traits, :physical_traits, :ruling_planet, :compatibility, :dates, :favorites, :scraper2, :symbol, :element, :famous_people, :secret_wish, :hates, :good_traits, :bad_traits, :mental_traits, :sun_dates]
    attr_accessor(*@@attributes)
    @@all = []

    def initialize(attributes)
        attributes.each {|key, value| self.send(("#{key}="), value) if self.methods.include?("#{key}=".to_sym)}
        @@all << self
    end

    def self.get_attributes
        @@attributes
    end

    def self.create_new_zodiacs
        Scraper.new.scrape
    end

    def self.all_dates
        self.all.map {|zodiac| zodiac.sun_dates}
    end

    def self.all_names
        self.all.map {|zodiac| zodiac.name }
    end

    #following method not used in program, but used to develop, debug, and edit using irb.
    def self.look_up_instance(zodiac_sign)
        Zodiac.all.each do |zodiac| 
            if zodiac.name == zodiac_sign
                return zodiac
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

