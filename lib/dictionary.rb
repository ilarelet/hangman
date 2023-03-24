class Dictionary
    attr_reader :words

    def initialize(dict_file)
        @words = Array.new
        File.open(dict_file, 'r') do |file|
            file.readlines.each do |word|
                @words.push word 
            end
        end
    end

    def random_word
        #Choose a random word between 5 and 12 characters long
        @words.select{|word| word.length >= 5 and word.length <= 12}.sample
    end

end