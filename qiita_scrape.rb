require 'nokogiri'
require 'open-uri'
require 'csv'

url = 'https://qiita.com/search?q=ruby'

charset = nil
titles = []

html = open(url) do |f|
    charset = f.charset
    f.read
end

doc = Nokogiri::HTML.parse(html, nil, charset)

doc.xpath('//h1[@class="searchResult_itemTitle"]').each do |node|
    title = node.css('a').inner_text
    titles.push(title)
end

csv = CSV.open("title.csv", "w")
csv << titles

#https://qiita.com/momokahori/items/851e4c36c5b5c4c2ef98　を参照