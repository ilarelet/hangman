require_relative 'dictionary.rb'
class Game
    attr_accessor :used_letters, :secret_word, :guessed, :mistakes

    def initialize(dictionary)
        #select a random secret word from the doctionary
        @secret_word = dictionary.random_word
        #create a display of guessed letters (so far all the letters are unguessed)
        @guessed =[]
        while @guessed.length < @secret_word.length
            guessed.push("_")
        end
        #the array of used letters will help the players keep track of what they already tried
        @used_letters = []
        @mistakes = 0
        #display the "new game" message
        self.start_msg
    end
    
    def start_msg
        puts "A new game begins!\n"
        puts "In this game you need to guess an English word we randomly chose for you. Good luck!\n"
        self.display_status
    end
    end

    def display_status
        puts "#{@mistakes} out of 7 mistakes made.\n" unless  @mistakes == 0
        puts "You've used the following letters: #{@used_letters.join(', ')}\n" unless  @used_letters == []
        puts "The word: |#{@guessed.join(' ')}|\n"
        puts 'Guess a letter: '
    end
end