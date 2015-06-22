json.array!(@ppls) do |ppl|
  json.extract! ppl, :id, :datum, :castka, :zaplaceno, :dobirka, :datumOdeslani, :cisloBaliku, :variabilniSymbol
  json.url ppl_url(ppl, format: :json)
end
