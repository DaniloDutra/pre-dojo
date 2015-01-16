class Ranking
  attr_reader :players

  def initialize(match)
    @match = match
    generate_player_rankings(match)
    generate_awards
  end

  def match_id
    @match.id
  end

  def winner
    rankings = @players
    first = rankings.first
    second = rankings.size > 1 ? rankings[1] : nil
    
    if second
      return first.kills > second.kills ? first : nil
    end

    first
  end

  def winner_favorite_weapon
    winner.favorite_weapon
  end

  def self.all
    matches = Matches.new.all
    rankings = []
    matches.each do |match|
      rankings << Ranking.new(match)
    end
    rankings
  end

  private

  def generate_awards
    winner_player = winner
    winner_player.awards += 1 if winner_player
  end

  def generate_player_rankings(match)
    valid_players = match.players.delete_if {|player| player.world? }
    @players = valid_players.sort_by { |player| player.kills }.reverse!
  end

end
