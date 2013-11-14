require 'import'

namespace :import do
  desc "Import Postcodes"
  task :postcodes => :environment do
    Import.postcodes
  end
  
  desc "Import Electoral districts"
  task :electoral => :environment do
    Import.electoraldistricts
  end

  desc "Import Parishes"
  task :parish => :environment do
    Import.parishes
  end

  desc "Import Codes"
  task :code => :environment do
    Import.codes
    Import.ni_codes
  end

end