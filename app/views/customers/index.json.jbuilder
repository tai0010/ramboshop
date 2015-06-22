json.array!(@customers) do |customer|
  json.extract! customer, :id, :jmeno, :prijmeni, :adresa, :mesto, :psc, :mobcislo, :poznamky, :datumkontaktu, :email, :kontaktovan, :odpoved
  json.url customer_url(customer, format: :json)
end
