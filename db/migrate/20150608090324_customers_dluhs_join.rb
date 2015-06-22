class CustomersDluhsJoin < ActiveRecord::Migration
 def up
  create_table :customers_dluhs, :id => false do |t|
  t.references :customer, :dluh
  end

  add_index :customers_dluhs, [:customer_id, :dluh_id]
end
  
  def down
    drop_table :customers_dluhs
  end
end
