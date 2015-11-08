class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  attr_accessor :word, :guesses, :check_win_or_lose, :wrong_guesses, :word_with_guesses
  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word.downcase()
    @guesses = ''
    @check_win_or_lose = :play
    @wrong_guesses = ''
    @word_with_guesses = '-'*@word.length
  end
  def guess(letter)
    if letter=='' or letter==nil or (letter =~ /[[:alpha:]]/) == nil
    	raise ArgumentError
    end
    letter = letter.downcase()
    if @word.include?(letter)
        if @guesses.include?(letter)
           return false
        end	   
        @guesses << letter
	letter_indices = (0 .. @word.length).find_all { |i| @word[i,1] ==letter }
        letter_indices.each { |ind| @word_with_guesses[ind]=letter }
	if @word_with_guesses == @word
		@check_win_or_lose = :win
	end
    else
	if @wrong_guesses.include?(letter) 
    	   return false
        end
	@wrong_guesses << letter
	if @wrong_guesses.length==7
		@check_win_or_lose = :lose
	end
    end
    return true
   
  end
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
