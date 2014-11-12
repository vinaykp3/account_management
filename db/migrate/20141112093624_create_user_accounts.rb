class CreateUserAccounts < ActiveRecord::Migration
  def change
    create_table :user_accounts do |t|
      t.string :name
      t.date :transaction_date
      t.string :transaction_place
      t.string :transaction_amount

      t.timestamps
    end
  end
end
