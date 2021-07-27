require 'rails_helper'

describe PuzzleParser do
  
  
  let(:test_puzzle_text) {"author\r\nGOTTA GO! By Fred Piscop\r\nlayout\r\n0102030405-106070809-110111213\r\n1400000000-115000000-116000000\r\n17000000001800000000-119000000\r\n20000000000000-1-1-
  12100000000\r\n-1-1-1-122000023-1240000000000\r\n252627280000-1293000000000-1-1\r\n3100000000-13200000000-1333435\r\n36000000-13700000000-138000000\r\n390000-14000000000-14100000000\r\n-1-14
  24300000000-1440000000000\r\n454600000000-147480000-1-1-1-1\r\n4900000000-1-1-150000051525354\r\n55000000-156575800000000000000\r\n59000000-160000000-16100000000\r\n62000000-163000000-164000
  00000\r\nsolution\r\nSPARS URIS SNAG\r\nKALEL DELT PUPA\r\nINFIELDFLY ATOM\r\nSTANDEE   SCARE\r\n    DART SCENTS\r\nSALOON HOWARD  \r\nEWING SEDAN BAT\r\nLAME HABIT BORE\r\nFYI SEGUE BILGE\r
  \n  TIARAS PROTON\r\nAMENDS HIRE    \r\nCADGE   TEASERS\r\nTIRE STOCKSPLIT\r\nONUS HASH TOSCA\r\nRENT ETSY STEER\r\nacross\r\n01|Exchanges verbal jabs\r\n06|\"Battle Cry\" novelist Leon\r\n1
  0|Hosiery ruiner\r\n14|Superman's birth name\r\n15|Upper-body muscle, for short\r\n16|Stage after larva\r\n17|Automatic out, in baseball\r\n19|Elemental unit\r\n20|Subway straphanger\r\n21|W
  hat a false alarm may cause\r\n22|Feathered projectile\r\n24|Sachet emanations\r\n25|Oater brawl scene\r\n29|Moe, Curly or Shemp\r\n31|Knicks great Patrick\r\n32|Accord or Camry\r\n33|Dugout
   rack item\r\n36|Poor, as excuses go\r\n37|Hard thing to kick, perhaps\r\n38|Gun barrel feature\r\n39|Memo heading, perhaps\r\n40|Smooth musical transition\r\n41|Ship's wastewater\r\n42|Prom
    queens' toppers\r\n44|19-Across component\r\n45|Revises, as a will\r\n47|Add to the staff\r\n49|Act the freeloader\r\n50|Movie trailers, e.g.\r\n55|Pit crew item\r\n56|Wall Street announce
    ment\r\n59|Cross to bear\r\n60|Greasy-spoon fare\r\n61|Puccini title character\r\n62|A squatter doesn't pay it\r\n63|Handicrafts site\r\n64|Bum ___ (bad tip)\r\ndown\r\n01|Biathlon gear\r\n
    02|Huff and puff\r\n03|Sporty auto, for short\r\n04|Harness part\r\n05|Iditarod team member\r\n06|Dairy cow part\r\n07|Ump's counterpart\r\n08|Green around the gills\r\n09|Place for a swill
     trough\r\n10|Orthodontic device\r\n11|Two-piece metal fastener\r\n12|To the left, at sea\r\n13|Wii purchases\r\n18|Low in fat, as pastrami\r\n21|All-in-one printer function\r\n23|Undevelop
     ed area, to an Aussie\r\n24|Police jacket letters\r\n25|Portraitist's subject, perhaps\r\n26|Like the visiting team\r\n27|Series with a predetermined end date\r\n28|Number on a foam finger
     \r\n30|Oft-kicked comics canine\r\n32|\"Roots,\" e.g.\r\n34|Best Picture of 2012\r\n35|Typical \"Belieber\"\r\n37|Towel word\r\n38|Tell-all book, for short\r\n40|Marquis de ___\r\n41|KFC s
     ervings\r\n43|Wolf down\r\n44|First school for some, briefly\r\n45|John Wilkes Booth, e.g.\r\n46|Only one-syllable state name\r\n48|Like a mosquito bite\r\n51|Lady Macbeth's \"damned\" thi
     ng\r\n52|Ultimatum ender\r\n53|\"Dirty\" Cajun fare\r\n54|Sticker on a perfect paper, perhaps\r\n56|___-crab soup\r\n57|Body ink, briefly\r\n58|WWII spy org.\r\nend\r\n"}
  
  before(:each) do
    httpparty = double
    HTTParty.should_receive(:get).and_return(httpparty)
    httpparty.should_receive(:parsed_response).and_return(test_puzzle_text)
    
  end
  
  describe "#initialize" do
   
   it "should initialize" do
     PuzzleParser.new.should_not == nil
   end 
  end
  
  describe "#byline" do
    it "should grab the byline from the puzzle text" do
      PuzzleParser.new.byline.should == ("GOTTA GO! By Fred Piscop")
    end
  end
  
  describe "#author" do
    it "should parse out the author from the byline" do
      PuzzleParser.new.author.should == ("Fred Piscop")
    end
  end
  
  describe "#title" do
    it "should parse out the title from the byline" do
      PuzzleParser.new.title.should == ("GOTTA GO!")
    end
  end
  
  describe "#editor" do
    xit "should return the editor of the crossword" do
      PuzzleParser.new.editor.should == ("Fred Piscop")
    end
  end
  
  describe "#publish_date" do
    it "should return a YYYY-MM-DD format from the given unix timestamp" do
      PuzzleParser.new(unix_timestamp: "1318996912").publish_date.should == DateTime.strptime("1318996912",'%s')
    end
  end
  
  describe "#height" do
    it "should return the height of the crossword" do
      PuzzleParser.new.height.should == ("15")
    end
  end 
  
  describe "#width" do
    it "should return the width of the crossword" do
      PuzzleParser.new.width.should == ("15")
    end
  end
  
  describe "#copyright" do
    xit "should return the copyright of the crossword" do
      PuzzleParser.new.copyright.should == ("15")
    end
  end
  
  describe "#date" do
    it "should return the unix timestamp of the beginning of the day for the timestamp entered" do
      PuzzleParser.new(unix_timestamp: "1318996912").date.should == "#{DateTime.strptime('1318996912','%s').beginning_of_day.to_i}"
    end
  end
  
  describe "#layout" do
    it "should return the layout of the puzzle" do
      PuzzleParser.new.layout.first.should == "0102030405-106070809-1101112139"
    end
  end
  
end