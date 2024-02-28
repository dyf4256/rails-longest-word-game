require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = []
    10.times do
      @letters << ('a'..'z').to_a.sample.upcase
    end
  end

  def score
    if params[:word]
      @word = params[:word]
      @letter_array = params[:letters].chars
      @letter_array.delete_at(-1)
      if self.letter_use_onece?(@letter_array, @word)
        if self.word_exist?(@word)
          @result = 'win'
        else
          @result = 'lose'
        end
      else
        @result = 'over'
      end
    end
  end

  private

  def word_exist?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    ser = URI.open(url).read
    return JSON.parse(ser)['found']
  end

  def letter_use_onece?(letters, word)
    word.chars.each do |letter|
      if letters.find_index(letter.upcase)
        letters.delete_at(letters.find_index(letter.upcase))
      else
        return false
      end
    end
    return true
  end
end
