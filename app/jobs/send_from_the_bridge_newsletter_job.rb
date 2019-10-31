class SendFromTheBridgeNewsletterJob < ApplicationJob
  queue_as :default

  def perform(zipcodes)
    zipcodes.each do |zipcode|
      FromTheBridgeMailer.send_newsletter(zipcode).deliver_now
    end
  end
end
