class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, limit:100, :null => false
      t.string :password_digest, limit:40, :null => false
      t.timestamps
    end
  end
end
