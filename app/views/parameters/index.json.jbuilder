json.array!(@parameters) do |parameter|
  json.extract! parameter, :tool_id, :parameter_type_id
  json.url parameter_url(parameter, format: :json)
end
