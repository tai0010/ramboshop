json.array!(@dluhs) do |dluh|
  json.extract! dluh, :id, :dluh, :poznamka
  json.url dluh_url(dluh, format: :json)
end
