#!/usr/bin/env ruby -wKU

# HW 1-6: Advanced OOP, Metaprogramming, Open Classes and Duck Typing 
# Part A — Currency conversion
class Numeric
 @@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019, 'dollar' => 1}
 def method_missing(method_id)
   singular_currency = method_id.to_s.gsub( /s$/, '')
   if @@currencies.has_key?(singular_currency)
     self * @@currencies[singular_currency]
   else
     super
   end
 end

 def in(currency)
   currency = currency.to_s.gsub( /s$/, '')
   self / @@currencies[currency]
 end
end

# Part B — Palindromes
class String
  def palindrome?
    temp = self.downcase.gsub(/(\W|\s)+/i,'')
    temp.reverse == temp.downcase
  end
end

"A man, a plan, a canal -- Panama".palindrome?  # => true
"Madam, I'm Adam!".palindrome?                  # => true
"Abracadabra".palindrome?                       # => false (nil is also ok)

# Part C — Palindromes again
module Enumerable
  def palindrome?(&block)
    if self.is_a? Array
      self.reverse == self
    elsif self.is_a? Enumerable and not self.is_a? Range
      true
    else
      false
    end
  end
end
[1,2,3,2,1].palindrome? # => true