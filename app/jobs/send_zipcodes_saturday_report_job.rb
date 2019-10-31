class SendZipcodesSaturdayReportJob < ApplicationJob
  queue_as :default

  # def perform(zipcodes)
  #   zipcodes.each do |zipcode|
  #     ZipcodesSaturdayMailer.send_report(zipcode).deliver_now
  #   end
  # end
  # def perform(report)
  #   ZipcodesSaturdayMailer.send_report(report).deliver_now
  # end
  def perform(zipcodes_with_saturday_enabled, zipcodes_with_saturday_disabled)
    ZipcodesSaturdayMailer.send_report(zipcodes_with_saturday_enabled, zipcodes_with_saturday_disabled).deliver_now
  end
end
