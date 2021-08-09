require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @letters = []
    10.times { @letters << alphabet.sample }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters]
    raise
    unless valid_letters? && valid_word?
      @word = "Sorry! That's not a valid word"
    end
  end

  private

  def valid_letters?
    @word.chars.uniq.all? { |char| @letters.count(char) >= @word.count(char) }
  end

  def valid_word?
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    result_serialized = URI.open(url).read
    JSON.parse(result_serialized)['found']
  end
end
