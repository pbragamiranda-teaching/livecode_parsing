require 'open-uri'
require 'nokogiri'

# Write a script that:
# 1. get the top 5 movies from topIMDB
# 2. access each individual page
# 3. get title, director, year, summary, top3actors/actress

# access top imdb page
# select the top 5
# store some where the urls

def fetch_movie_urls
  top_url = "https://www.imdb.com/chart/top"
  # open the url
  html_file = URI.open(top_url).read
  # parse with nokogiri
  html_doc = Nokogiri::HTML(html_file)

  top_movies = []
  html_doc.search(".titleColumn a").first(5).each do |movie|
    top_movies << "https://www.imdb.com#{movie.attribute('href')}"
  end
  top_movies
end

# access each individual page
# find the right selectors for title, director, year, summary, top3actors/actress
# store somewhere
# return a hash

def scrape_movie(movie)
  # info_hash = {}
  movie_url = movie

  html_file = URI.open(movie_url, "Accept-Language" => "en").read
  html_doc = Nokogiri::HTML(html_file)

  title = html_doc.search("h1").text.split("(")[0]
  year  =  html_doc.search("#titleYear").text.gsub(/\W/, "").to_i
  director = html_doc.search("h4:contains('Director:') + a").text
  summary = html_doc.search(".summary_text" ).text.strip # investigate
  top3 = html_doc.search(".primary_photo + td a").first(3).map do |a|
    a.text.strip
  end

  {
   cast: top3,
   director: director,
   storyline: summary,
   title: title,
   year: year
  }

end

# puts scrape_movie("http://www.imdb.com/title/tt0468569/")

# godfather = "https://www.imdb.com/title/tt0068646/"
# html_file = URI.open(godfather).read
# html_doc = Nokogiri::HTML(html_file)
# title
# puts html_doc.search("h1").text.split("(")[0]
# year
# puts html_doc.search("#titleYear").text.gsub(/\W/, "")

# director
# puts html_doc.search("h4:contains('Director:') + a").text

# summary
# puts html_doc.search(".summary_text" ).text # investigate

# top3 ac/acs
# top_actors = []
# html_doc.search(".primary_photo + td a").first(3).each do |a|
#   top_actors << a.text.strip
# end

# top_actors = html_doc.search(".primary_photo + td a").first(3).map do |a|
#   a.text.strip
# end

