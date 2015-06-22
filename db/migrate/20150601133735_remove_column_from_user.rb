class RemoveColumnFromUser < ActiveRecord::Migration
  def change
    remove_column :uzivatels, :login
  end
end
