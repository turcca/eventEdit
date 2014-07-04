json.array!(@chosen_parameters) do |chosen_parameter|
  json.extract! chosen_parameter, :chosen_tool_id, :parameter_value_id
  json.url chosen_parameter_url(chosen_parameter, format: :json)
end
