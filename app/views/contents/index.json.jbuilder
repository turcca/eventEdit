json.array!(@contents) do |content|
  json.extract! content, :ancestry, :type, :text, :condition, :tool1, :skill1, :equality1, :andor, :tool2, :skill2, :equality2, :event_id
  json.url content_url(content, format: :json)
end
