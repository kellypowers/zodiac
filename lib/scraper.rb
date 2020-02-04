# require 'nokogiri'
# require 'open-uri'

# require_relative './zodiac.rb'

# class Scraper

# def get_page
#     html= open("https://en.wikipedia.org/wiki/Astrological_sign")
#     doc = Nokogiri::HTML(html)
# end

# def get_signs_and_dates
#     signs_and_dates = get_page.css(".table, tr")
#     puts signs_and_dates

#     #signs_and_dates = doc.css("html body #content #bodyContent #mw-content-text .wikitable sortable jquery-tablesorter")
#     #puts signs_and_dates

#     signs = signs_and_dates.css("#mw-content-text.mw-parser-output>tbody>tr>td:nth-child(3),a.innerHTML") #Taurus
#     puts signs
#     dates = signs_and_dates.css("tbody,tr,td:nth-child(4)") 
#     puts dates
# end#dates taurus
#     i = 1
#    while i < 12 do  
# #     ("#mw-content-text.mw-parser-output>tbody>tr, tr>td:nth-child("#{i}"),a.innerHTML") #Gemini
# #     ("#mw-content-text.mw-parser-output>tbody>tr, tr>td:nth-child("#{i}"") #gemini dates 
# i += 1
# # (   "#mw-content-text.mw-parser-output>tbody>tr:nth-child(3)>td:nth-child(3),a.innerHTML") #Aries
# #     ("#mw-content-text.mw-parser-output>tbody>tr:nth-child(3)>td:nth-child(4)") #dates 
# #     #each tr is its own sign 
# #     #taurus is in 3rd<td> <atag href innerHTML 
# #     #dates are on 4th <td> tag , just between the two td tags 
# #     ("#mw-content-text.mw-parser-output>tbody>tr:nth-child(4)td:nth-child(3),a.innerHTML") #sign
# #     ("#mw-content-text.mw-parser-output>tbody>tr:nth-child(4)>td:nth-child(4)") #dates 

# #     ("#mw-content-text.mw-parser-output>tbody>tr:nth-child(5)>td:nth-child(3),a.innerHTML") #sign
# #     ("#mw-content-text.mw-parser-output>tbody>tr:nth-child(5)>td:nth-child(4)") #dates 

# #     ("#mw-content-text.mw-parser-output>tbody>trtr:nth-child(6)>td:nth-child(3),a.innerHTML") #sign
# #     ("#mw-content-text.mw-parser-output>tbody>trtr:nth-child(6)>td:nth-child(4)") #dates 

# #     ("#mw-content-text.mw-parser-output>tbody>trtr:nth-child(7)>td:nth-child(3),a.innerHTML") #sign
# #     ("#mw-content-text.mw-parser-output>tbody>trtr:nth-child(7)>td:nth-child(4)") #dates 

# #     ("#mw-content-text.mw-parser-output>tbody>trtr:nth-child(8)>td:nth-child(3),a.innerHTML") #sign
# #     ("#mw-content-text.mw-parser-output>tbody>trtr:nth-child(8)>td:nth-child(4)") #dates 

# #     ("#mw-content-text.mw-parser-output>tbody>trtr:nth-child(9)>td:nth-child(3),a.innerHTML") #sign
# #     ("#mw-content-text.mw-parser-output>tbody>trtr:nth-child(9)>td:nth-child(4)") #dates 

# #     ("#mw-content-text.mw-parser-output>tbody>trtr:nth-child(10)>td:nth-child(3),a.innerHTML") #sign
# #     ("#mw-content-text.mw-parser-output>tbody>trtr:nth-child(10)>td:nth-child(4)") #dates 

# #     ("#mw-content-text.mw-parser-output>tbody>trtr:nth-child(11)>td:nth-child(3),a.innerHTML") #sign
# #     ("#mw-content-text.mw-parser-output>tbody>trtr:nth-child(11)>td:nth-child(4)") #dates 

# #     ("#mw-content-text.mw-parser-output>tbody>trtr:nth-child(12)>td:nth-child(3),a.innerHTML") #sign
# #     ("#mw-content-text.mw-parser-output>tbody>trtr:nth-child(12)>td:nth-child(4)") #dates 



#     #transfer date to integers

# #end

# puts doc.css("table tbody tr td:nth-child(3) a") 
# will give me titles , 