class Tool4 < ActiveRecord::Migration
   Customer.all.each do |c|
    if !c.rating.present?
      puts c.id
    end
  end
end
