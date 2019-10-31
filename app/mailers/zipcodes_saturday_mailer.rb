class ZipcodesSaturdayMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.zipcodes_saturday_mailer.send_report.subject
  #
  def send_report(zipcodes_with_saturday_enabled, zipcodes_with_saturday_disabled)
    email = "abc@123.com"    
    @greeting = "Hi, here is the weekly report"
    # @report = report
    @zipcodes_with_saturday_enabled = zipcodes_with_saturday_enabled
    @zipcodes_with_saturday_disabled = zipcodes_with_saturday_disabled
    @enabled_count = zipcodes_with_saturday_enabled.count
    @disabled_count = zipcodes_with_saturday_disabled.count
    mail(to: email, subject: 'Saturday Zipcodes Report')
    puts "Report sent to #{email}"
  end

  def send_special_report(zipcode)
    email = "abc@123.com"    
    @greeting = "Hi, a special interest zipcode has become active for Saturday Delivery"
    @special_zipcode = zipcode.code
    mail(to: email, subject: 'Special Interest Zipcode has become Active')
    puts "Special Report for zipcode #{@special_zipcode} sent to #{email}"
  end

end
