require 'open-uri'
require 'nokogiri'
require 'byebug'

urls = [
    'http://www.inter-nauka.com/issues/2015/9/592/'
]

file = File.open('output.txt', 'w')

urls.each do |url|
  en_url = url.split('/').insert(3,'en').join('/')

  page = Nokogiri::HTML(open(en_url))

  # Parsing general information
  # TODO: add section parsing into this part
  title = page.css('div[record] .page-header a').text
  file << 'Title: ' + title.capitalize + "\n"

  author = ''
  authors = page.css('div[record] .page-header + .row a')
  if authors.size == 1
    author = authors.text
  elsif authors.size > 1
    authors.each_with_index { |a, i| i == (authors.size - 1) ? author += a.text : author += a.text.concat(', ') }
  end

  file << 'Author: ' + author + "\n"

  basic_info = page.css('div[record] br+div p')
  basic_info.map do |p|
    p.css('strong').remove
  end
  summary, keywords = basic_info.map(&:text)
  file << 'Summary: ' + summary + "\n"
  file << 'Key Words: ' + keywords + "\n"

  section = page.css('b:contains("Branch of science:") + a').text
  file << 'Section: ' + section + "\n"

  file << '-------------------------------------------' + "\n"

  # Parsing text of an article
  page = Nokogiri::HTML(open(url)).css('hr + div')

  page.search('div[style="text-align: center;"]').each { |div| puts div.text; div.remove }

  page.search('p').each do |p|
    puts p.text
    p.remove
    break if p.text.downcase.include?('key words:')
  end

  article_text = page.children.to_html.strip
  file << article_text

end

file.close