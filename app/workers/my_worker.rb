class MyWorker < SimpleWorker::Base
  
  def run
       require 'csv'
       require 'net/ftp'
      #Dir.chdir(Rails.root.join("tmp")) do
               Net::FTP.open("ftp.dctalentphotovideo.com") do |ftp|
                 ftp.passive = true
                 ftp.login('telemagic@dctalentphotovideo.com', 'shaina99')
                 ftp.chdir("uploads")
                 file = ftp.nlst("*.txt")
                 #@file = file
                 file.each{|filename| #Loop through each element of the array
                   ftp.getbinaryfile(filename,filename) #Get the file
                 }
               end
               filename = "000075.txt"
            CSV.foreach(filename, {:headers => true, :col_sep => "|"}) do |row|
              Contract.find_or_create_by_unique3(row[0])
              Contract.update_attributes({ 
               :unique3             =>  row[0],
               :prntkey23             =>  row[1],
               :prntkey13         =>  row[2],
               :act_code            =>  row[3],
               :agent       => row[7],
               :act_booked => row[8],
               :contract_number    => row[28],
               :type_of_event    => row[63],
               :date_of_event    => row[67],
               :first_name    => row[68],
               :last_name    => row[69],
               :confirmation => 0 }
              )

     # end
    end
    
  end
  
end