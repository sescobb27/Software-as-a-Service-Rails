#!/usr/bin/env ruby -wKU

# HW 1-1: Fun with strings 
# Part A — Palindromos:
def palindrome?(string)
    string.downcase!.gsub!(/(\W|\s)+/i,'')
    string.reverse == string
end

palindrome?("A man, a plan, a canal -- Panama")  # => true
palindrome?("Madam, I'm Adam!")                  # => true
palindrome?("Abracadabra")                       # => false (nil is also ok)

# Part B — Word Count:
def count_words(string)
    dict = {}
    string.downcase.gsub!(/\b\w*[^\W*]\b/){ |w|
      p w
      if dict.has_key? w
        dict[w] += 1
      else
        dict[w] = 1
      end
    } if string != ""
    dict
end

count_words("A man, a plan, a canal -- Panama")
# => {'a' => 3, 'man' => 1, 'canal' => 1, 'panama' => 1, 'plan' => 1}
count_words "Doo bee doo bee doo"
# => {'doo' => 3, 'bee' => 2}