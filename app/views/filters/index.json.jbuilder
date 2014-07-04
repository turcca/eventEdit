json.array!(@filters) do |filter|
  json.extract! filter, :name
  json.url filter_url(filter, format: :json)
end
