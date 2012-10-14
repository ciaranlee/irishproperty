namespace :importer do
  desc "Import all csv files in the data directory"
  task :import => :environment do
    csv_files = Dir.glob("data/*.csv")
    if csv_files.any?
      puts "importing"
      csv_files.each do |filename|
        Sale.import_from_csv filename
      end
    else
      puts "there were no CSV files in the data directory, please move them in to ths directory and try again"
    end
  end
end

