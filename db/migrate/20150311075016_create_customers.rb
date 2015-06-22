class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :jmeno
      t.string :prijmeni
      t.string :adresa
      t.string :mesto
      t.integer :psc
      t.integer :mobcislo
      t.string :poznamky
      t.date :datumkontaktu
      t.string :email
      t.boolean :kontaktovan
      t.boolean :odpoved

      t.timestamps
    end
  end
end
