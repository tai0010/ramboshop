class CustomersPoznamkasJoin < ActiveRecord::Migration
   def up
  create_table :customers_poznamkas, :id => false do |t|
  t.references :customer, :poznamka
  end

  add_index :customers_poznamkas, [:customer_id, :poznamka_id]
end
  
  def down
    drop_table :customers_poznamkas
  end
end
