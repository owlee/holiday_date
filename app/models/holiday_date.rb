class HolidayDate < ActiveRecord::Base
  belongs_to :holiday
  belongs_to :calendar_date
  belongs_to :country
end
