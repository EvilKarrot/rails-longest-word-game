require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = ("A".."Z").to_a
    @grid = []
    10.times { @grid << @letters.sample }
    @grid
  end

  def score
    @answer = params[:answer]

    url = "https://dictionary.lewagon.com/#{@answer}"
    serialized_guess = URI.parse(url).read
    guess = JSON.parse(serialized_guess)
    @response =
      if guess["found"]
        if @answer.upcase.chars.tally.all? { |key, value| value <= params[:grid].chars.tally[key].to_i }
          "Congratulations! #{@answer.upcase} is a valid English word!"
        else
          "Sorry but #{@answer.upcase} can't be built ouit of #{params[:grid]}"
        end
      else
        "Sorry but #{@answer.upcase} does not seem to be a valid English word..."
      end
  end

end
