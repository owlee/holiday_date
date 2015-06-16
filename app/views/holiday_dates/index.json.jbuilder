json.array!(@holiday_dates) do |holiday_date|
  json.extract! holiday_date, :id, :holiday_id, :calendar_date_id
  json.url holiday_date_url(holiday_date, format: :json)
end
