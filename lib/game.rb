class Game
    attr_accessor :used_letters, :secret_word, :guessed, :turn

    def initialize(dictionary)
        #select a random secret word from the doctionary
        @secret_word = dictionary.random_word
        #create a display of guessed letters (so far all the letters are unguessed)
        @secret_word.each {|letter| @guessed.push("_")}
        #the array of used letters will help the players keep track of what they already tried
        @used_letters = []
        @turn = 1
        #display the "new game" message
        self.start_msg
    end
    
    def start_msg
        puts 'A new game begins!'
        puts
        puts 'In this game you need to guess an English word we randomly chose for you.'
    end