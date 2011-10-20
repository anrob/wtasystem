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
    
  end
  
end