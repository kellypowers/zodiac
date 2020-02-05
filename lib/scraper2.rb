class Scraper2
    attr_accessor :parse_for_info, :parse_page

    def get_page
        doc = Nokogiri::HTML(open("https://zodiacal.herokuapp.com/api"))
        my_hash = JSON.parse(doc)
        my_hash
    end

    def name_array(my_hash)
        new_array = []
        my_hash.each {|i| new_array << i["name"]}
        new_array
    end

    def parse_for_info(my_hash, zodiac_name)
    #zodiac name = user input to zodiac return value
    attributes = {}
        keys_zodiac = []
        values_zodiac = []
        my_hash.each do |i|
            if i["name"] == zodiac_name
                attributes = i
            end
        end
    attributes
    end


end