require_relative 'dictionary.rb'
require_relative 'game.rb'

dictionary = Dictionary.new('google-10000-english-no-swears.txt')
game = Game.new(dictionary)
game.play_game