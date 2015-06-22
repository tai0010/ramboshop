class Createuzivatels < ActiveRecord::Migration
  def change
     create_table :uzivatels do |t|
      t.string :login, limit:30, :null => false
      t.string :password_digest, limit:40, :null => false

      t.timestamps
    end
  end
end
