class Holiday < ActiveRecord::Base
  belongs_to :country
  has_many :holiday_dates
  has_many :calendar_dates, through: :holiday_dates

 	#def self.occurences_during year
	#	soy = Date.new(year)
		#eoy = soy.end_of_year
	#	self.where(calendar_dates)
 	#end
end