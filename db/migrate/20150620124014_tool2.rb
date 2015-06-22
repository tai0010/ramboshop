class Tool2 < ActiveRecord::Migration
 Customer.all.each do |c|
      rating = Rating.create(:customer_id=>c,:rating=>0)
      rating.save
      c.rating = rating
      puts "jo"
    end
end
