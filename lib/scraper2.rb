class Scraper2
    attr_accessor :parse_for_info, :parse_page


    def scrape
        zodiac_hashes = get_page
        zodiac_hashes.each do |z_hash|
            Zodiac2.new(z_hash)
        end
    end
    def get_page
        doc = Nokogiri::HTML(open("https://zodiacal.herokuapp.com/api"))
        JSON.parse(doc)
    end

    def name_array
        zodiac_hashes = get_page
        zodiac_hashes.map {|i| i["name"]}
    end
    #["Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", "Libra", "Scorpio", "Sagittarius", "Capricorn", "Aquarius", "Pisces"] 

    def date_array
        zodiac_hashes = get_page
        zodiac_hashes.map {|i| i["sun_dates"]}
    end
    #[["March 21", "April 19"], ["April 20", "May 20"], ["May 21", "June 20"], ["June 21", "July 22"], ["July 23", "August 22"], ["August 23", "September 22"], ["September 23", "October 22"], ["October 23", "November 21"], ["November 22", "December 21"], ["December 22", "January 19"], ["January 20", "February 18"], ["February 19", "March 20"]] 



end