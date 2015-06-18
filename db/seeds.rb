#class Seed
#	require 'httparty'
#	include HTTParty
#	base_uri 'base_uri "http://holidayapi.com/v1'
#	attr_acessor :country, :year
#
#	def initialize(country, year)
#		self.class.country = country
#		self.class.year = year
#	end
#
#	#we get a hash for the Country's calendar on some year
#	def get_calendar
#		self.class.get "/holidays?country=#{country}&year=#{year}"
#	end
#
#	def get_json_calendar
#		response = self.class.get "/holidays?country=#{country}&year=#{year}"
#		holiday = JSON.parse(response.body)
#	end
#end

Country.delete_all

countries = ["US", "BE", "BR", "GB", "NO"]

puts "Adding Country Codes into Countries"
countries.each do |c|
	Country.where(name: c ).first_or_create
end
puts "Finished Adding Country Codes into Countries"

#puts "Adding days up to 30 years from 1/1/2015"

i_date = Date.new(2015,1,1)
f_date = Date.new(2045,1,1)
i_year = i_date.year
f_year = f_date.year

CalendarDate.delete_all

loopd = i_date

while(loopd.year <= f_date.year)
	puts loopd.to_s
	CalendarDate.where(date: loopd.to_s ).first_or_create
	loopd = loopd.next
end

puts "Finished adding days from #{i_date.to_s} to #{f_date.to_s}"


puts "going through and adding all the holidays"
Holiday.delete_all


HolidayDate.delete_all


Country.all.each do |c|
	puts "Loading holidays into calendar starting with country #{c.name}"
	(i_year..f_year).each do |y|

		response = HTTParty.get("http://holidayapi.com/v1/holidays?country=#{c.name}&year=#{y}").body
		calen = JSON.parse(response)["holidays"]

		i = 1

		puts "Loading each holiday name into holiday database"
		calen.each do |date, arr|
			arr.each do |hash|
				puts "#{i}: adding #{hash["name"]} to database"
				i +=1
				Holiday.where(name: hash["name"]).first_or_create
			end
		end
		puts "DONE: with #{c.name}"

		cid = Country.find_by(name: c.name).id

		calen.each do |date, arr|
			did = CalendarDate.find_by(date: date).id
			arr.each do |hash|
				puts "updating the calendardate relationship between holidays, countries, and date"
				hid = Holiday.find_by(name: hash["name"]).id
				
		
				puts "countryid = #{cid}, dateid = #{did}, holidayid: #{hid}"

				HolidayDate.create(country_id: cid, calendar_date_id: did, holiday_id: hid)
			end
		end
		puts "***finshing year: #{y}"
	end
	puts "Finishing country #{c.name}"
end
