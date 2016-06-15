require 'open-uri'

SECTIONS = [
    'Technical sciences',
    'Economic sciences',
    'Social media',
    'Legal science'
]

ARTICLE_URLS = [
  # Technical Sciences
  'http://www.inter-nauka.com/issues/2015/9/592',
  'http://www.inter-nauka.com/issues/2016/4/1089',
  'http://www.inter-nauka.com/issues/2015/9/614',
  'http://www.inter-nauka.com/issues/2016/5/1221',
  'http://www.inter-nauka.com/issues/2016/5/1129',
  'http://www.inter-nauka.com/issues/2016/5/1100',

  # Legal science
  'http://www.inter-nauka.com/issues/2016/2/780',
  'http://www.inter-nauka.com/issues/2016/2/778',
  # Social media
  'http://www.inter-nauka.com/issues/2016/2/865',
  'http://www.inter-nauka.com/issues/2016/3/978',
  # Economic sciences
  'http://www.inter-nauka.com/issues/2016/5/1196',
  'http://www.inter-nauka.com/issues/2016/5/1175',
  'http://www.inter-nauka.com/issues/2016/5/1123',
  'http://www.inter-nauka.com/issues/2016/4/1084'
]

# Admin
user = User.create!(
    email: 'alexeymazurik@gmail.com',
    password: 'demodemo1234',
    password_confirmation: 'demodemo1234',
    admin: true
)

# Ivan
User.create!(
    email: 'ivan@example.com',
    password: 'demodemo1234',
    password_confirmation: 'demodemo1234'
)

# Dmitriy
User.create!(
    email: 'dmitriy@example.com',
    password: 'demodemo1234',
    password_confirmation: 'demodemo1234'
)

# Ihor
User.create!(
    email: 'ihor@example.com',
    password: 'demodemo1234',
    password_confirmation: 'demodemo1234'
)

# Aleksey
User.create!(
    email: 'aleksey@example.com',
    password: 'demodemo1234',
    password_confirmation: 'demodemo1234'
)

# Alexander
User.create!(
    email: 'alexander@example.com',
    password: 'demodemo1234',
    password_confirmation: 'demodemo1234'
)

SECTIONS.each do |section|
  Section.create!(name: section)
end

ARTICLE_URLS.each do |url|
  en_url = url.split('/').insert(3,'en').join('/')

  page = Nokogiri::HTML(open(en_url))
  title = page.css('div[record] .page-header a').text.capitalize
  author = ''
  authors = page.css('div[record] .page-header + .row a')
  if authors.size == 1
    author = authors.text
  elsif authors.size > 1
    authors.each_with_index { |a, i| i == (authors.size - 1) ? author += a.text : author += a.text.concat(', ') }
  end
  basic_info = page.css('div[record] br+div p')
  basic_info.map do |p|
    p.css('strong').remove
  end
  summary, keywords = basic_info.map(&:text)
  keywords = keywords.chop.split(', ')
  section = page.css('b:contains("Branch of science:") + a').text

  # Parsing text of an article
  page = Nokogiri::HTML(open(url)).css('hr + div')
  page.search('div[style="text-align: center;"]').each { |div| div.remove }
  page.search('p').each do |p|
    p.remove
    break if p.text.downcase.include?('key words:')
    break if p.text.downcase.include?('keywords:')
  end

  article_text = page.children.to_html.strip

  Post.create!(
          title: title,
          text: article_text,
          annotation: summary,
          user_id: user.id,
          author: author,
          section_id: Section.where(name: section).first.id,
          tag_list: keywords
  )
end



