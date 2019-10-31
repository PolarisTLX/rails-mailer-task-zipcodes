# Preview all emails at http://localhost:3000/rails/mailers/zipcodes_saturday
class ZipcodesSaturdayPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/zipcodes_saturday/send_report
  def send_report
    ZipcodesSaturdayMailer.send_report
  end

end
