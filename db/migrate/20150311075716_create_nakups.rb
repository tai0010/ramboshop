class CreateNakups < ActiveRecord::Migration
  def change
    create_table :nakups do |t|
      t.float :cena_nakupu
      t.date :datum_nakupu
      t.boolean :planovanynakup

      t.timestamps
    end
  end
end
