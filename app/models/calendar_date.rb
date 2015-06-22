class CalendarDate < ActiveRecord::Base
  has_many :holiday_dates
  has_many :holidays, through: :holiday_dates
  has_many :calendar_dates, through: :holiday_dates
end
