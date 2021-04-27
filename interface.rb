require 'yaml'
require_relative "scraper"

puts "Fetching urls for top 5 movies in IMDB database"
urls = fetch_movie_urls


movies = urls.map do |url|
  puts "Scrapigin #{url}"
  scrape_movie(url)
end

puts "Writing data into yml file"
File.open("movies.yml", "w") do |file|
   file.write(movies.to_yaml)
end
