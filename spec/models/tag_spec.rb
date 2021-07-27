require 'rails_helper'

describe Tag do
  ActiveRecord::Base.connection.execute('SET foreign_key_checks = 0;')
  
  describe "#get_bundles" do
    it "should return empty dates" do
      
    end 
  end
  
end