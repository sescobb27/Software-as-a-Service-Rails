#!/usr/bin/env ruby -wKU

# ==============================================================================
=begin
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

=end

# ==============================================================================
=begin
# HW 1-2: Rock-Paper-Scissors 
class WrongNumberOfPlayersError <  StandardError ; end
class NoSuchStrategyError <  StandardError ; end

def rps_game_winner(game)
    raise WrongNumberOfPlayersError unless game.length == 2
    patron = /[psr]/i
    player1_name = game[0][0]
    player1_hand = game[0][1].upcase
    player2_name = game[1][0]
    player2_hand = game[1][1].upcase
    raise NoSuchStrategyError unless player1_hand =~ patron and player2_hand =~ patron
    case player1_hand
      when player2_hand
        # gana player 1
        # "#{player1_name} #{player1_hand}"
        game[0]
      when 'R'
        if player2_hand == 'S'
          # gana player1 tijeras
          # "#{player1_name} #{player1_hand}"
          game[0]
        else
          # gana player2 papel
          # "#{player2_name} #{player2_hand}"
          game[1]
        end
      when 'S'
        if player2_hand == 'R'
          # gana player1 roca
          # "#{player2_name} #{player2_hand}"
          game[1]
        else
          # gana player2 papel
          # "#{player1_name} #{player1_hand}"
          game[0]
        end      
      when 'P'
        if player2_hand == 'R'
          # gana player1
          # "#{player1_name} #{player1_hand}"
          game[0]
        else
          # gana player2
          # "#{player2_name} #{player2_hand}"
          game[1]
        end
    end
end

def rps_tournament_winner(tournament)
  winners = []
  tournament.each do |group|
    group.each do |figths|
      begin
        winners << rps_game_winner(figths)
      rescue NoMethodError => e
        figths.each do |inside|
          inside.each do |ins|
            winners << rps_game_winner(ins)
          end
        end
      end
    end
  end
  while winners.size > 1
    winners << rps_game_winner([winners.shift, winners.shift])
  end
  winners[0]
end
=end

# ==============================================================================
=begin
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

=end

# ==============================================================================
=begin
# HW 1-4: Basic Object Oriented Programming 
# OOP herencia y polimorfismo
class Dessert
  attr_accessor :name, :calories
    def initialize(name, calories)
        @name = name
        @calories = calories
    end

    def healthy?
        @calories < 200
    end

    def delicious?
        true
    end
end

class JellyBean < Dessert
    attr_accessor :flavor
    def initialize(name, calories, flavor)
        super name, calories
        @flavor = flavor
    end

    def delicious?
        if @flavor == "black licorice" then false
        else super
        end
    end
end

=end

# ==============================================================================
=begin
# HW 1-5: Advanced OOP, Metaprogramming, Open Classes and Duck Typing
# metaprograming programacion dinamica
class Class
    def attr_accessor_with_history(*args)
      # recorrer los parámetros para crear sus respectivos métodos y arreglos
      args.each do |attr_name|
        # para cada symbol crear su respectivo getter
        attr_reader attr_name
        # volver el symbol un String para usarlo como nombre de metodo y como
        # nombre de variable i.e ( bar=(args), bar_history )
        method_name = attr_name.to_s
        # al nivel de la clase que invoca este método se ejecutara el siguiente
        # código en tiempo de ejecución, otorgándole nuevos métodos y atributos
        # %Q es para crear un String multilinea
        class_eval %Q(
          def #{method_name}=(args)
            @#{method_name} = args
            @#{method_name}_array ||= [nil]
            @#{method_name}_array << args
          end

          def #{method_name}_history
            @#{method_name}_array
          end
        )
      end
    end

end

class Foo
    attr_accessor_with_history :bar
end

f = Foo.new     # => #<Foo:0x127e678>
f.bar = 3       # => 3
f.bar = :wowzo  # => :wowzo
f.bar = 'boo!'  # => 'boo!'
f.bar_history   # => [nil, 3, :wowzo, 'boo!']

=end

# ==============================================================================
=begin
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
=end

# ==============================================================================
=begin
# HW 1-7: Iterators, Blocks, Yield
class CartesianProduct
    include Enumerable
    def initialize(vector1,vector2)
      @vector1, @vector2 = vector1, vector2
    end

    def each(&block)
      @vector1.each do |value_v1|
        @vector2.each do |value_v2|
          yield [value_v1,value_v2]
        end
      end
    end
end
c = CartesianProduct.new([:a,:b], [4,5])
c.each { |elt| puts elt.inspect }
# [:a, 4]
# [:a, 5]
# [:b, 4]
# [:b, 5]

c = CartesianProduct.new([:a,:b], [])
c.each { |elt| puts elt.inspect }
# Nothing printed since Cartesian product of anything with an empty collection is empty

=end
