class Scraper

    def scrape
        zodiac_hashes = get_page
        zodiac_hashes.each do |z_hash|
            Zodiac.new(z_hash)
        end
    end
    def get_page
        doc = Nokogiri::HTML(open("https://zodiacal.herokuapp.com/api"))
        JSON.parse(doc)
    end

end