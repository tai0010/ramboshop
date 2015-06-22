class AddColumnToDluhs < ActiveRecord::Migration
  def change
    add_column :dluhs, :active, :boolean
  end
end
