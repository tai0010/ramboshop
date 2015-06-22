class NakupsZbozisJoin < ActiveRecord::Migration
  def up
  create_table :nakups_zbozis, :id => false do |t|
  t.references :nakup, :zbozi
  end

  add_index :nakups_zbozis, [:nakup_id, :zbozi_id]
end
  
  def down
    drop_table :nakups_zbozis
  end
end
