json.array!(@transactions) do |transaction|
  json.extract! transaction, :cube
  json.url transaction_url(transaction, format: :json)
end
