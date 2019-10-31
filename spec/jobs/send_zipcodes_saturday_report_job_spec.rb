require 'rails_helper'
# require 'database_cleaner/active_record'

# DatabaseCleaner.strategy = :truncation

RSpec.describe SendZipcodesSaturdayReportJob, type: :job do
  # let(:zipcodes) { FactoryBot.create_list(:zipcode, 5) }

  # allzipcodes = Zipcode.all

  # zipcodes_with_saturday_enabled = []
  # zipcodes_with_saturday_disabled = []
  # allzipcodes.each do |zipcode|
  #   puts ">> Zipcode: #{zipcode.code} - Saturday_enabled?: #{zipcode.saturday_enabled}"
  #   entry = { zipcode: zipcode.code, Saturday_enabled?: zipcode.saturday_enabled, city: zipcode.city }
  #   zipcodes_with_saturday_enabled << entry if zipcode.saturday_enabled 
  #   zipcodes_with_saturday_disabled << entry if !zipcode.saturday_enabled 
  # end

  # puts "zipcodes_with_saturday_enabled: #{zipcodes_with_saturday_enabled}"
  # puts "enabled count: #{zipcodes_with_saturday_enabled.count}"
  # puts "zipcodes_with_saturday_disabled: #{zipcodes_with_saturday_disabled}"
  # puts "disabled count: #{zipcodes_with_saturday_disabled.count}"
 

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
    # SendZipcodesSaturdayReportJob.perform_now(zipcodes_with_saturday_enabled, zipcodes_with_saturday_disabled)
    SendZipcodesSaturdayReportJob.perform_now
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end

end
