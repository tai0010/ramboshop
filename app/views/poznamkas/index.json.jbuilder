json.array!(@poznamkas) do |poznamka|
  json.extract! poznamka, :id, :datum, :poznamka
  json.url poznamka_url(poznamka, format: :json)
end
