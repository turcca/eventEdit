json.array!(@tools) do |tool|
  json.extract! tool, :name, :tooltype, :character, :probability, :content_condition, :content_effect, :pre_tool
  json.url tool_url(tool, format: :json)
end
