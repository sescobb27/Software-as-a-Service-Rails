#!/usr/bin/env ruby -wKU

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