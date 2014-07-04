json.array!(@advice_contents) do |advice_content|
  json.extract! advice_content, :type, :condition, :tool_id, :equality, :value, :and, :text
  json.url advice_content_url(advice_content, format: :json)
end
