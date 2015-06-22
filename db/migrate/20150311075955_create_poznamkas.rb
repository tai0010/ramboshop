class CreatePoznamkas < ActiveRecord::Migration
  def change
    create_table :poznamkas do |t|
      t.date :datum
      t.string :poznamka

      t.timestamps
    end
  end
end
