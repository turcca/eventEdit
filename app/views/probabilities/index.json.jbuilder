json.array!(@probabilities) do |probability|
  json.extract! probability, :condition, :tool1, :equality1, :value1, :andor, :tool2, :equality2, :value2, :p
  json.url probability_url(probability, format: :json)
end
