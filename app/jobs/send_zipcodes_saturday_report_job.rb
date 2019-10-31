class SendZipcodesSaturdayReportJob < ApplicationJob
  queue_as :default

  # def perform(zipcodes_with_saturday_enabled, zipcodes_with_saturday_disabled)
  #   ZipcodesSaturdayMailer.send_report(zipcodes_with_saturday_enabled, zipcodes_with_saturday_disabled).deliver_now
  # end
  def perform

    Benchmark.bm(35) do |benchmark|  # The 20 is the width of the first column in the output.
      benchmark.report("Time in sec prepare + send report:") do 

        allzipcodes = Zipcode.all

        zipcodes_with_saturday_enabled = []
        zipcodes_with_saturday_disabled = []
        special_zipcodes = ["98001","93725","80238","17339"]

        allzipcodes.each do |zipcode|
          puts ">> Zipcode: #{zipcode.code} - Saturday_enabled?: #{zipcode.saturday_enabled}"
          entry = { zipcode: zipcode.code, Saturday_enabled?: zipcode.saturday_enabled, city: zipcode.city }
          zipcodes_with_saturday_enabled << entry if zipcode.saturday_enabled 
          zipcodes_with_saturday_disabled << entry if !zipcode.saturday_enabled 


          # FOR SPECIAL INTEREST ZIPCODES
          if special_zipcodes.include?(zipcode.code) && zipcode.saturday_enabled
            puts "Special zipcode '#{zipcode.code}' has become enabled for Saturday Delivery"
            ZipcodesSaturdayMailer.send_special_report(zipcode)
          end
        end

        puts "zipcodes_with_saturday_enabled: #{zipcodes_with_saturday_enabled}"
        puts "enabled count: #{zipcodes_with_saturday_enabled.count}"
        puts "zipcodes_with_saturday_disabled: #{zipcodes_with_saturday_disabled}"
        puts "disabled count: #{zipcodes_with_saturday_disabled.count}"

        ZipcodesSaturdayMailer.send_report(zipcodes_with_saturday_enabled, zipcodes_with_saturday_disabled).deliver_now

      end
    end
    
  end
end
