#encoding: windows-1250 
require 'csv'

namespace :csv do

  desc "Import CSV Data from Zbozis"
  task :zbozis => :environment do
    Zbozi.delete_all
    csv_file_path = 'db/zbozis.csv'

    CSV.foreach(csv_file_path,"r:WINDOWS-1250") do |row|
     # if row.length > 10  #wanted to ignore some straggling data and blank spaces in the file
        Zbozi.create!({
          :id=>row[0],
          :nazev => row[1],
          :popis => row[2],
          :nakup_id => row[3],  
          :pocet_kusu => row[4],
          :cena_za_kus => row[5]
        })
        puts "Row added!"
      end
    #end
    
    Zbozi.all.each do |p|
      if Nakup.where(:id=>p.nakup_id).present?
        v = Nakup.find(p.nakup_id)
        v.zbozis << p
        v.save
        puts "Row added!"
      end
    end
    
  end
end