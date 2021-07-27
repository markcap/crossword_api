require 'open-uri'
class XmlParser
  
  def initialize(options = {})
    @options = options
    @feature = Feature.find_by_feature_code(@options[:feature_code])
    asset_url_variable = asset_url
    @parsed_xml = asset_url_variable ? Nokogiri::XML(open(asset_url)) : ""
  end
  
  def puzzle_data
    puzzle_data_hash = {}
    ["date", "author", "editor", "title", "height", "width", "copyright", "layout", "solution", "clues"].map{|x| puzzle_data_hash[x] = send(x)}
    puzzle_data_hash
  end
  
  def author
    get_xml_value("Author").gsub("By ", "")
  end
  
  def title
    URI.unescape(get_xml_value("Title"))
  end
  
  def editor
    amu_editors = ["erik agard", "amanda rafkin"]
    amu_editors.include?(get_xml_value("Editor").downcase) ? get_xml_value("Editor") : "Erik Agard"
  end
  
  def asset_url
    return nil if publish_date.to_date > Date.today
    if @feature
      @feature.assets.where(issue_date: publish_date, mime_type: 'text/html', asset_type: 'webready').where("filepath LIKE ?", "%data%").first&.asset_url
    end
  end
  
  def publish_date
    DateTime.strptime(@options[:unix_timestamp],'%s') if @options[:unix_timestamp]
  end
  
  def width
    "15"
  end
  
  def height
    "15"
  end
  
  def copyright
    get_xml_value("Copyright")
  end
  
  def date
    "#{publish_date.beginning_of_day.to_i}"
  end
  
  def layout
    layout_array = Array.new(225)

    clues_hash("down")[:clue_numbers].each do |key, value|
      layout_array[key-1] = value
    end
    clues_hash("across")[:clue_numbers].each do |key, value|
      layout_array[key-1] = value
    end
    solution.join("").each_char.with_index(1) do |char, index|
      layout_array[index-1] = "-1" if char == "-"
    end
    
    layout_array.map! { |x| x || "00" }
    layout_array.join("").scan(/.{30}/)
  end
  
  def solution
    get_xml_value("AllAnswer").scan(/.{15}/)
  end
  
  def clues
    {"down" => clues_hash("down")[:clues], "across" => clues_hash("across")[:clues]}
  end
  
  def clues_hash(direction)
    clues_hash, clue_numbers_hash = {}, {}
    @parsed_xml.xpath("//#{direction}").children.each_with_index do |section, index|
      clues_hash[section.attributes["cn"].value.rjust(2, "0")] = URI.unescape(section.attributes["c"].value) if index.odd?
      clue_numbers_hash[section.attributes["n"].value.to_i] = section.attributes["cn"].value.rjust(2, "0") if index.odd?
    end
    {clues: clues_hash, clue_numbers: clue_numbers_hash}
  end
  
  private 
  
  def get_xml_value(section)
    @parsed_xml.xpath("//#{section}")[0].attributes["v"].value if @parsed_xml.xpath("//#{section}")[0]
  end
  
end