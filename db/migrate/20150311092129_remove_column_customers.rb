class RemoveColumnCustomers < ActiveRecord::Migration
  def change
    remove_column :Customers, :poznamky
  end
end
