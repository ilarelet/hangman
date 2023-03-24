class Dictionary
    attr_reader :words, :size

    def initialize(dict_file)
        @words = Hash.new
        File.open(dict_file, 'r').readlines.each do |word|
            @words[word] = word.length
        end
        @size = @words.length
    end
end