class Game
    require 'json'

    def initialize(dictionary)
        #select a random secret word from the doctionary
        @secret_word = dictionary.random_word.upcase
        #create a display of guessed letters (so far all the letters are unguessed)
        @guessed =[]
        while @guessed.length < @secret_word.length
            @guessed.push("_")
        end
        #the array of used letters will help the players keep track of what they already tried
        @used_letters = []
        @mistakes = 0
    end

    def prompt_guess
        begin
            puts 'GUESS A LETTER or type "save" to save the game and exit: '
            letter = gets.chomp.upcase
            if letter == "SAVE"
                self.savegame
                exit
            end
            #the input has to be a single letter (between A and Z)
            if letter.length != 1
                puts 'Please enter one letter at a time!'
                raise
            end
            if letter < 'A' or letter > 'Z'
                puts 'Please enter a letter!'
                raise
            end
            if @used_letters.include?(letter) or @guessed.include?(letter)
                puts "You already tried #{letter}. Make a different guess!" 
                raise 
            end
        rescue 
            retry
        end
        check_letter(letter)
    end

    def check_letter(letter)
        if @secret_word.include?(letter)
            puts 'Good guess!'
            @guessed.map.with_index do |item, index|
                if @secret_word[index] == letter
                    @guessed[index] = letter
                end
            end
        else
            puts "Sorry, \"#{letter}\" is not in the word we guessed."
            @mistakes += 1
            @used_letters.push letter
        end
        puts
    end

    def play_game
        #display the "new game" message
        self.start_msg
        while @mistakes < 7
            self.prompt_guess
            self.display_status
            if @guessed.join("") == @secret_word
                puts "Congratulations! You won the game!"
                return
            end
        end
        puts "Sorry you've made 7 mistakes. Game over, you've lost."
        puts "The correct answer was #{@secret_word.upcase}"
    end
    
    def start_msg
        puts "Welcome to hangman!"
        puts "If you'd like to load an old game enter 'load'. If you want to start a new game press 'Enter' or type anything else"
        if gets.chomp.downcase == "load"
            self.loadgame
        else
            puts "A new game begins!"
            puts
            puts "In this game you need to guess an English word we randomly chose for you. Good luck!"
        end
        self.display_status
    end

    def display_status
        puts "#{@mistakes} out of 7 mistakes made." unless  @mistakes == 0
        puts "You've used the following letters: #{@used_letters.join(', ')}" unless  @used_letters == []
        puts "The word: | #{@guessed.join(' ')} |"
        puts
    end

    def savegame
        savefile = File.open('savefile.json', 'w') 
        savedata = {secret_word: @secret_word, mistakes: @mistakes, guessed: @guessed, used_letters: @used_letters}
        File.write(savefile, JSON.pretty_generate(savedata))
        savefile.close
        puts "Game saved!"
    end

    def loadgame
        begin
        savefile = File.read('savefile.json')
        loaddata = JSON.parse(savefile)
        #if the file is empty create a new game
        raise if loaddata['secret_word'] == nil
        @secret_word = loaddata['secret_word']
        @mistakes = loaddata['mistakes']
        @guessed = loaddata['guessed']
        @used_letters = loaddata['used_letters']
        puts 'Game loaded!'

        rescue
            puts 'Game loading failed - no file found. Starting a new game...'
            return
        end
    end
end