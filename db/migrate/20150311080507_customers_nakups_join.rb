class CustomersNakupsJoin < ActiveRecord::Migration
  def up
  create_table :customers_nakups, :id => false do |t|
  t.references :customer, :nakup
  end

  add_index :customers_nakups, [:customer_id, :nakup_id]
end
  
  def down
    drop_table :customers_nakups
  end
end
