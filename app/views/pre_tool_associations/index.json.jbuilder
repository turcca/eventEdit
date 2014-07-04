json.array!(@pre_tool_associations) do |pre_tool_association|
  json.extract! pre_tool_association, :pre_tool_id, :tool_id
  json.url pre_tool_association_url(pre_tool_association, format: :json)
end
