class AddColumnToPoznamky < ActiveRecord::Migration
  def change
    add_column :poznamkas, :customer_id, :integer
    
  end
end
