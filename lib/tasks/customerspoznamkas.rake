#encoding: windows-1250 
require 'csv'

namespace :csv do

  desc "Import CSV Data from Customers"
  task :customerspoznamkas => :environment do
    
    poznamky = Poznamka.all
    poznamky.each do |p|
      if Customer.where(:id=>p.customer_id).present?
        v = Customer.find(p.customer_id)
        v.poznamkas << p
        v.save
        puts "Row added!"
      end
    end
  end
end