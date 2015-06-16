class AddCountryIdDateIdHolidayIdToHolidayDate < ActiveRecord::Migration
  def change
  	add_column :holiday_dates, :country_id, :integer
  end
end
