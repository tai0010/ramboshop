class CreatePpls < ActiveRecord::Migration
  def change
    create_table :ppls do |t|
      t.date :datum
      t.float :castka
      t.boolean :zaplaceno
      t.boolean :dobirka
      t.date :datumOdeslani
      t.text :cisloBaliku
      t.text :variabilniSymbol

      t.timestamps
    end
  end
end
