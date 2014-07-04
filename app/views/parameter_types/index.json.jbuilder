json.array!(@parameter_types) do |parameter_type|
  json.extract! parameter_type, :name
  json.url parameter_type_url(parameter_type, format: :json)
end
