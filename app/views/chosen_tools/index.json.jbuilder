json.array!(@chosen_tools) do |chosen_tool|
  json.extract! chosen_tool, :tool_id, :pre_tool_id
  json.url chosen_tool_url(chosen_tool, format: :json)
end
