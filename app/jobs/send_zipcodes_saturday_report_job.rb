class SendZipcodesSaturdayReportJob < ApplicationJob
  queue_as :default

  def perform(zipcodes)
    zipcodes.each do |zipcode|
      ZipcodesSaturdayMailer.send_report(zipcode).deliver_now
    end
  end
end
