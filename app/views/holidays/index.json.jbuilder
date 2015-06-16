json.array!(@holidays) do |holiday|
  json.extract! holiday, :id, :name, :country_id
  json.url holiday_url(holiday, format: :json)
end
