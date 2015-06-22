class Createuzivatelsaa < ActiveRecord::Migration
  def change
    add_column :uzivatels, :email, :string, :limit => 100
    change_column :uzivatels, :email, :string, :limit => 100, :null => false
  end
end
