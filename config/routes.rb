Rails.application.routes.draw do
  devise_for :users
  use_doorkeeper do
    skip_controllers :authorizations, :applications,
      :authorized_applications
  end
  
  get "/puzzle/(:unix_timestamp)", to: 'puzzles#show', feature_code: "usaon"
  # get "/tournament/(:unix_timestamp)", to: 'puzzles#show', feature_code: "usaont"
  get "/tournament/(:unix_timestamp)", to: 'puzzles#tournament'
  get "/puzzlePacks/(:pack_name)", to: 'puzzles#packs'
  get "/empty_dates", to: 'puzzles#empty_dates'
  
end
