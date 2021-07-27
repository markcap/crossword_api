class Asset < ApplicationRecord
  belongs_to :feature
  
  def asset_url
    "https://assets.amuniversal.com/#{asset_uuid}"
  end
end