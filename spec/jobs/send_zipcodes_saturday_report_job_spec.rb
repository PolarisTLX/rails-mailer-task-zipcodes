require 'rails_helper'

RSpec.describe SendZipcodesSaturdayReportJob, type: :job do
  let(:zipcodes) { FactoryBot.create_list(:zipcode, 5) }

  before do
    ActionMailer::Base.deliveries.clear
  end

  after do
    ActionMailer::Base.deliveries.clear
  end

  it "sends email with report on which zipcodes are enable for Saturday delivery" do
    SendZipcodesSaturdayReportJob.perform_now(zipcodes)
    expect(ActionMailer::Base.deliveries.count).to eq(5)
  end

end
