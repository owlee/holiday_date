class HolidayDate < ActiveRecord::Base
  require 'searchbing'
  belongs_to :holiday
  belongs_to :calendar_date
  belongs_to :country

  def get_image search
  	bing_image = Bing.new('FXQ9j3tk3v3LxuHiiEiQtCuAQcmMztT0Ub8yVkBsor0', 1, 'Image')
  	bing_results = bing_image.search(search)
  	bing_results[0][:Image][0][:Thumbnail][:MediaUrl]
  end
end
