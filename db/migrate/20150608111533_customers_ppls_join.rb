class CustomersPplsJoin < ActiveRecord::Migration
   def up
  create_table :customers_ppls, :id => false do |t|
  t.references :customer, :ppl
  end

  add_index :customers_ppls, [:customer_id, :ppl_id]
end
  
  def down
    drop_table :customers_ppls
  end
end
