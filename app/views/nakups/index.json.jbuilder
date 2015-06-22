json.array!(@nakups) do |nakup|
  json.extract! nakup, :id, :cena_nakupu, :datum_nakupu, :planovanynakup
  json.url nakup_url(nakup, format: :json)
end
