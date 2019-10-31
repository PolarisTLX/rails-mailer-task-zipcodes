require 'rails_helper'
# require 'database_cleaner/active_record'

# DatabaseCleaner.strategy = :truncation

RSpec.describe SendZipcodesSaturdayReportJob, type: :job do
  # let(:zipcodes) { FactoryBot.create_list(:zipcode, 5) }

  allzipcodes = Zipcode.all
  # puts ">>>>> #{allzipcodes}"
  # puts ">>>>> Zipcode.first #{Zipcode.first}"

  # report = []
  zipcodes_with_saturday_enabled = []
  zipcodes_with_saturday_disabled = []
  allzipcodes.each do |zipcode|
    puts ">> Zipcode: #{zipcode.code} - Saturday_enabled?: #{zipcode.saturday_enabled}"

    # report << { zipcode: zipcode.code, Saturday_enabled?: zipcode.saturday_enabled, city: zipcode.city }
    entry = { zipcode: zipcode.code, Saturday_enabled?: zipcode.saturday_enabled, city: zipcode.city }
    zipcodes_with_saturday_enabled << entry if zipcode.saturday_enabled 
    zipcodes_with_saturday_disabled << entry if !zipcode.saturday_enabled 
      # ?  
      # : zipcodes_with_saturday_disabled << entry
  end

  # puts "report: #{report}"
  puts "zipcodes_with_saturday_enabled: #{zipcodes_with_saturday_enabled}"
  puts "zipcodes_with_saturday_disabled: #{zipcodes_with_saturday_disabled}"
 

  before do
    ActionMailer::Base.deliveries.clear
    DatabaseCleaner.clean
    load "#{Rails.root}/db/seeds.rb" 
  end

  after do
    ActionMailer::Base.deliveries.clear
  end

  it "sends email with report on which zipcodes are enable for Saturday delivery" do
    # SendZipcodesSaturdayReportJob.perform_now(zipcodes)
    # SendZipcodesSaturdayReportJob.perform_now(report)
    SendZipcodesSaturdayReportJob.perform_now(zipcodes_with_saturday_enabled, zipcodes_with_saturday_disabled)
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end

end
