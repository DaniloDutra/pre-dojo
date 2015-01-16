$: << File.dirname(__FILE__) + "/../lib"

require 'formatador'
require 'match'
require 'player'
require 'event'
require 'log_parser'
require 'matches'

matches = Matches.new.all
matches.each do |match|
  players_table = []
  Formatador.display_line("Match ##{match.id}")
  Formatador.display_line("Favorite Weapon of the Winner: #{match.winner_favorite_weapon}")
  match.player_rankings.each do |player|
    players_table << { player: player.name, kills: player.kills, deaths: player.deaths }
  end
  Formatador.display_table(players_table, [:player, :kills, :deaths])
end
