 FactoryBot.define do

   factory :asset do
     feature
     filename "that file.jpg"
     asset_type :webready
     sequence(:asset_uuid) {|n| "name#{n}"}
   end
  
  factory :feature do
    sequence(:name) {|n| "mark#{n}"}
    feature_type :comic
    format :strip
    alt_format :strip
    alt_format_weekday 1
    sequence(:short_name) {|n| "name#{n}"}
    sequence(:sort_name) {|n| "name#{n}"}
    sequence(:feature_code) {|n| "code#{n}"}
    copyright "ff"
    amu_reprints true
    syndicate_id 1
  end
  
  factory :publication do
    feature
    asset_issue_date Date.parse('2014/1/1')
    publish_date Date.parse('2014/1/1')
  end
  
  factory :user do
    sequence(:username) {|n| "username#{n}"}
    sequence(:first_name) {|n| "firstname#{n}"}
    sequence(:last_name) {|n| "lastname#{n}"}
    sequence(:email) {|n| "emailu#{n}@amuniversal.com"}
    password "hellooo"
    password_confirmation "hellooo"
  end

  factory :tag do
    sequence(:name) {|n| "tag#{n}"}
  end
end