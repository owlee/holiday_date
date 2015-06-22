class Holiday < ActiveRecord::Base
  belongs_to :country
  has_many :holiday_dates
  has_many :calendar_dates, through: :holiday_dates
end