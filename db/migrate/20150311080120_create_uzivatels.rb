class CreateUzivatels < ActiveRecord::Migration
  def change
    create_table :uzivatels do |t|
      t.string :login
      t.string :heslo

      t.timestamps
    end
  end
end
