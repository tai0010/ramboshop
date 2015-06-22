class AddColumnToPoznamky2 < ActiveRecord::Migration
  def change
    change_column :poznamkas, :customer_id, :integer, :null => false
  end
end
