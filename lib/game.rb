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
        puts "A new game begins!"
        puts
        puts "In this game you need to guess an English word we randomly chose for you. Good luck!"
        self.display_status
    end

    def display_status
        puts "#{@mistakes} out of 7 mistakes made." unless  @mistakes == 0
        puts "You've used the following letters: #{@used_letters.join(', ')}" unless  @used_letters == []
        puts "The word: | #{@guessed.join(' ')} |"
        puts
    end

    def prompt_guess
        begin
            puts 'Guess a letter: '
            letter = gets.chomp.upcase
            #the input has to be a single letter (between A and Z)
            raise 'Please enter one letter at a time!' if letter.length != 1
            raise 'Please enter a letter!' if letter <= 'A' or letter >= 'Z'
            if @used_letters.include?(letter) or @guessed.include?(letter)
                raise "You already tried #{letter}. Make a different guess!" 
            end
        rescue 
            retry
        end

        check_letter(letter)
    end

    def check_letter(letter)
        if @secret_word.include?(letter)
            puts 'Good guess!'
            @guessed.map!.with_index do |item, index|
                if @secret_word[index] == letter
                    @guessed[index] == letter
                end
            end
        else
            puts "Sorry, \"#{letter}\" is not in the word we guessed."
            mistakes += 1
            used_letters.push letter
        end
    end
end