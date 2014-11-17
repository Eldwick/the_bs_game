require 'open-uri'

categories = [["/business/money/","money.asp"],["/disney/films/","films.asp"],["/history/american/","american.asp"],["/history/world/","world.asp"],["/food/tainted/","tainted.asp"],["/movies/actors/","actors.asp"],["/science/","science.asp"]]

categories.each do |category|

  link = open("http://www.snopes.com#{category[0]}")
  doc = Nokogiri::HTML(link)

  links = doc.css("a + img + a")

  links_array = []
  links.each do |link|
    links_array << link[:href]
  end

  links_array.each do |link_url|
    begin
      claim_url = open("http://www.snopes.com#{category[0]}#{link_url}")
      claim_doc = Nokogiri::HTML(claim_url)
      claim = nil
      status = nil
      claim_doc.css(".article_text").text.split("\n").each do |claim_line|
        claim = claim_line.gsub("Claim:","").strip if claim_line.include? "Claim"
      end

      claim_doc.css("noindex td").text.split("\n").each do |claim_status_line|
        status = claim_status_line.strip if (claim_status_line.include? "TRUE") || (claim_status_line.include? "FALSE")
      end
      claim[0..1] = '' if claim

      if status == "TRUE" || status == "FALSE"
        status = status == "TRUE"
        claim_params = {
          subject: claim,
          truth: status,
          category: "money"
        }
        Claim.create(claim_params) 
      end
    rescue
      puts "failed"
    end
  end
end