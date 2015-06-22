class CreateDluhs < ActiveRecord::Migration
  def change
    create_table :dluhs do |t|
      t.float :dluh
      t.string :poznamka

      t.timestamps
    end
  end
end
