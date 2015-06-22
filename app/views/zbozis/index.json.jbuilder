json.array!(@zbozis) do |zbozi|
  json.extract! zbozi, :id, :nazev, :popis, :pocet_kusu, :cena_za_kus
  json.url zbozi_url(zbozi, format: :json)
end
