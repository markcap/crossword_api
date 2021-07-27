class Feature < ApplicationRecord
  has_many :assets
  
  def empty_dates
    dates_with_crosswords = assets.where(mime_type: 'text/html', asset_type: 'webready').map(&:issue_date)
    all_dates = (Date.parse("2003-04-19")..Date.today).map{|x| x}
    all_dates - dates_with_crosswords
  end
end