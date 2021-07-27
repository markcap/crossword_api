class Tag < ApplicationRecord
  has_many :taggings
  
  def self.get_bundles(options = {})
    bundles = {}
    tags = Tag.where("name like ?", "%_bundle")
    tags.each do |tag|
      bundles["#{tag.name.gsub('_bundle', '')}"] = tag.taggings.map{|x| Publication.find(x.taggable_id).publish_date.to_time.to_i}
    end
    #Transforming into normal dates if option is passed
    bundles = bundles.each_with_object({}){|(key, value), array| array[key] = value.map{|x| DateTime.strptime(x.to_s,'%s').strftime("%Y-%m-%d")}} if options["format"] == "date"
    bundles.delete_if {|key, value| value.empty? }
  end
end