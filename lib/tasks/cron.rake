desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  Store.load_all_stores_cafepress_data
end