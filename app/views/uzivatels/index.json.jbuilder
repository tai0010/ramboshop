json.array!(@uzivatels) do |uzivatel|
  json.extract! uzivatel, :id, :login, :heslo
  json.url uzivatel_url(uzivatel, format: :json)
end
