json.array!(@secondary_prereqs) do |secondary_prereq|
  json.extract! secondary_prereq, :event_id, :prereq_id
  json.url secondary_prereq_url(secondary_prereq, format: :json)
end
