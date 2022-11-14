require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @array = generate_code(10)
  end
  def score
    @word = params[:word]

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_long = URI.open(url).read
    wordparse = JSON.parse(word_long)
    @result = @word.upcase.chars.all? { |letter| @word.upcase.chars.count(letter) <= params["letters"].chars.count(letter) }
      if wordparse["found"]
        if @result
          @score = "CONGRATULATION, #{@word} is a valid english word, you got #{@word.size}"
        else
          @score = "not in the grid"
        end
      else
        @score = "sorry but #{@word} is not english"
      end
  end
# Le mot ne peut pas être créé à partir de la grille d’origine.
# Le mot est valide d’après la grille, mais ce n’est pas un mot anglais valide.
# Le mot est valide d’après la grille et est un mot anglais valide.

  def generate_code(number)
    charset = Array('A'..'Z')
    Array.new(number) { charset.sample }
  end
end
