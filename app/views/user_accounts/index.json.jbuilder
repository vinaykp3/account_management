json.array!(@user_accounts) do |user_account|
  json.extract! user_account, :id, :name, :transaction_date, :transaction_place, :transaction_amount
  json.url user_account_url(user_account, format: :json)
end
