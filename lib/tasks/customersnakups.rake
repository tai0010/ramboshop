#encoding: windows-1250 
require 'csv'

namespace :csv do

  desc "Import CSV Data from Customers"
  task :customersnakups => :environment do
    
    nakupy = Nakup.all
    nakupy.each do |n|
      if Customer.where(:id=>n.customer_id).present?
        a = Customer.find(n.customer_id)
        a.nakups << n
        a.save
        puts "Row added!"
      end
    end
    
    Nakup.all.each do |a|
      if !a.customer.present?
        a.destroy
      end
    end
  end
end