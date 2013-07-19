#!/usr/bin/env ruby -wKU

# HW 1-3: Anagrams 
def combine_anagrams(words)
  result = []
  words.each do |word|
    added = false
    if result.size > 0
      result.each do |arr|
        arr.each do |el|
          if el.downcase.chars.sort == word.downcase.chars.sort
            arr << word
            added = true
            break
          end
        end
        break if added
      end
    end
    result << [word] unless added
  end
  result
end

# input: ['cars', 'for', 'potatoes', 'racs', 'four', 'scar', 'creams', 'scream'] 
# output: [ ["cars", "racs", "scar"],
#           ["four"],
#           ["for"],
#           ["potatoes"],
#           ["creams", "scream"] ]