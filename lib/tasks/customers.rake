#encoding: windows-1250 
require 'csv'

namespace :csv do

  desc "Import CSV Data from Customers"
  task :customers => :environment do
    Customer.delete_all
    csv_file_path = 'db/customers.csv'

    CSV.foreach(csv_file_path,"r:WINDOWS-1250") do |row|
      if row.length > 10  #wanted to ignore some straggling data and blank spaces in the file
        Customer.create!({
          :id=>row[0],
          :jmeno => row[1],
          :prijmeni => row[2],
          :adresa => row[3],  
          :mesto => row[4],
          :psc => row[5],     
          :mobcislo => row[6],     
          :datumkontaktu => row[8],
          :email => row[9],    
          :kontaktovan => row[10],
          :odpoved => row[11],
          :barva => "bila"
        })
        puts "Row added!"
      end
    end
  end
end