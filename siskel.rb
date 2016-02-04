require 'httparty'

class Siskel
  attr_accessor :title, :rating, :year, :plot, :options, :tomato
   def initialize(title, options = {})
     @options = options
     url = 'http://www.omdbapi.com/?' + stuff(title, @options)
     movie = HTTParty.get(url)
     @tomato = movie['tomatoMeter'].to_i
     @title = movie['Title'] || 'Movie not found!'
     @rating = movie['Rated']
     @year = movie['Year']
     @plot = movie['Plot']
   end

  def stuff(title, stuff)
    parameters = []
    parameters.push "t=#{title}"
    parameters.push 'tomatoes=true'
    parameters.push "y=#{options[:year]}" if options[:year]
    parameters.push "plot=#{options[:plot]}" if options[:plot]
    parameters.join('&')
  end

  def consensus
    if @tomato.between?(76, 100)
         'Two Thumbs Up'
       elsif @tomato.between?(51, 75)
         'Thumbs Up'
       elsif @tomato.between?(26, 50)
         'Thumbs Down'
       else
         'Two Thumbs Down'
       end
     end
end
