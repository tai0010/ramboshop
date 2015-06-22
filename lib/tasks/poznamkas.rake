#encoding: windows-1250 
require 'csv'

namespace :csv do

  desc "Import CSV Data from Poznamkas"
  task :poznamkas => :environment do
    Poznamka.delete_all
    csv_file_path = 'db/poznamkas.csv'

    CSV.foreach(csv_file_path,"r:WINDOWS-1250") do |row|

    #  if row.length > 4  #wanted to ignore some straggling data and blank spaces in the file
        Poznamka.create!({
          :id => row[0],
          :customer_id => row[1],
          :datum => row[2],
          :poznamka => row[3]
        })
        puts "Row added!"
     # end
    end
  end
end