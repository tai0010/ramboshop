class CreateZbozis < ActiveRecord::Migration
  def change
    create_table :zbozis do |t|
      t.string :nazev
      t.string :popis
      t.integer :pocet_kusu
      t.float :cena_za_kus

      t.timestamps
    end
  end
end
