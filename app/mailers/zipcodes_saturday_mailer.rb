class ZipcodesSaturdayMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.zipcodes_saturday_mailer.send_report.subject
  #
  def send_report(zipcode)
    puts "report sent"
    @greeting = "Hi"

    mail to: "abc@123.com"
  end
end
