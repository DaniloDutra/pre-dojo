$: << File.dirname(__FILE__) + "/../lib"

require 'formatador'
require 'match'
require 'player'
require 'event'
require 'log_parser'
require 'matches'
require 'awards'
require 'ranking'

ranks = Ranking.all
ranks.each do |rank|
  players_table = []
  Formatador.display_line("Match ##{rank.match_id}")
  Formatador.display_line("Favorite Weapon of the Winner: #{rank.winner_favorite_weapon}")
  rank.players.each do |player|
    players_table << { player: player.name, kills: player.kills, deaths: player.deaths, killstreak: player.killstreak, awards: player.awards }
  end
  Formatador.display_table(players_table, [:player, :kills, :deaths, :killstreak, :awards])
end
