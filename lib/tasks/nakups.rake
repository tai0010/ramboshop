#encoding: windows-1250 
require 'csv'

namespace :csv do

  desc "Import CSV Data from Nakups"
  task :nakups => :environment do
    Nakup.delete_all
    csv_file_path = 'db/nakups.csv'

    CSV.foreach(csv_file_path,"r:WINDOWS-1250") do |row|
     # if row.length > 5  #wanted to ignore some straggling data and blank spaces in the file
        Nakup.create!({
          :id=>row[0],
          :customer_id => row[1],
          :cena_nakupu => row[2],
          :datum_nakupu => row[3],  
          :planovanynakup => row[4]
        })
        puts "Row added!"
     # end
    end
  end
end