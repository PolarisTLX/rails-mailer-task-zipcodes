namespace :newsletters do
  desc "Send weekly newsleter from the Captain"
  task zipcodessaturday: :environment do
    SendZipcodesSaturdayNewsletterJob.perform_later
  end

end
