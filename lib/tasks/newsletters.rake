namespace :newsletters do
  desc "Send weekly newsleter rom the Captain"
  task from_the_bridge: :environment do
    SendFromTheBridgeNewsletterJob.perform_later
  end

end
