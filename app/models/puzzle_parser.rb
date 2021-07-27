class PuzzleParser
  
  def initialize(options = {})
    @options = options
    @feature = Feature.find_by_feature_code(@options[:feature_code])
    asset_url_variable = asset_url
    text_response = asset_url_variable ? HTTParty.get(asset_url_variable).parsed_response : ""
    @puzzle_array = text_response.include?("\r\n") ? text_response.split("\r\n") : text_response.split("\n")
  end
  
  def puzzle_data
    puzzle_data_hash = {}
    ["date", "author", "editor", "title", "height", "width", "copyright", "layout", "solution", "clues"].map{|x| puzzle_data_hash[x] = send(x)}
    puzzle_data_hash
  end
  
  def byline
    @puzzle_array[@puzzle_array.index("author").to_i + 1] || "Default"
  end
  
  def author
    offset_index = byline.index(/ by | By | BY /) || 0
    byline[(offset_index + 4)..byline.length-1]
  end
  
  def title
    offset_index = byline.index(/ by | By | BY /) || 0
    byline[0..offset_index-1]
  end
  
  def editor
    author
  end
  
  def asset_url
    if @feature
      @feature.assets.where(issue_date: publish_date, mime_type: 'text/plain', asset_type: 'webready').first&.asset_url
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
    @feature.copyright
  end
  
  def date
    "#{publish_date.beginning_of_day.to_i}"
  end
  
  def layout
    get_puzzle_data_between("layout", "solution")
  end
  
  def solution
    get_puzzle_data_between("solution", "across").map{|x| x.gsub(" ", "-")}
  end
  
  def clues
    {"down" => down_clues_hash, "across" => across_clues_hash}
  end
  
  def down_clues_hash
    down_clues_array = get_puzzle_data_between("down", "end")
    clues_hash = {}
    down_clues_array.map{|x| clues_hash[x[0..1]] = x[3..x.length-1] }
    clues_hash
  end
  
  def across_clues_hash
    across_clues_array = get_puzzle_data_between("across", "down")
    clues_hash = {}
    across_clues_array.map{|x| clues_hash[x[0..1]] = x[3..x.length-1] }
    clues_hash
  end
  
  private

  def get_puzzle_data_between(section1, section2)
    (@puzzle_array[@puzzle_array.index(section1).to_i+1..@puzzle_array.index(section2).to_i-1]).to_a
  end
  
end