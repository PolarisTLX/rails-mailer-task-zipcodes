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
        allzipcodes.each do |zipcode|
          puts ">> Zipcode: #{zipcode.code} - Saturday_enabled?: #{zipcode.saturday_enabled}"
          entry = { zipcode: zipcode.code, Saturday_enabled?: zipcode.saturday_enabled, city: zipcode.city }
          zipcodes_with_saturday_enabled << entry if zipcode.saturday_enabled 
          zipcodes_with_saturday_disabled << entry if !zipcode.saturday_enabled 
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
