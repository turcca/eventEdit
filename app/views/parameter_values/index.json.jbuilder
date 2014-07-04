json.array!(@parameter_values) do |parameter_value|
  json.extract! parameter_value, :parameter_type_id, :name
  json.url parameter_value_url(parameter_value, format: :json)
end
