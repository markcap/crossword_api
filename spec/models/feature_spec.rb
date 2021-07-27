require 'rails_helper'

describe Feature do
  ActiveRecord::Base.connection.execute('SET foreign_key_checks = 0;')
  
  describe "#empty_dates" do
    it "should return empty dates" do
      feature = FactoryBot.create(:feature)
      asset = FactoryBot.create(:asset, mime_type: 'text/html', asset_type: 'webready', issue_date: Date.parse("2005-04-19"), feature_id: feature.id)
      feature.empty_dates.should_not include(Date.parse("2005-04-19"))
    end 
  end
  
end