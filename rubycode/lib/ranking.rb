class Ranking
  attr_reader :players

  TOTAL_KILLS_TO_AWARDS = 5
  MAX_SECONDS_TO_KILLS = 60

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
    winner_player.awards += 1 if winner_player and winner_player.deaths == 0

    @players.each do |player|
      start_kills_date = nil
      total_kills, awards = 0,0
      player.events.each do |event|
        if event.from_player == player
          start_kills_date ||= event.created_at
          total_kills += 1 if event.created_at <= (start_kills_date + MAX_SECONDS_TO_KILLS)

          if total_kills == TOTAL_KILLS_TO_AWARDS
            awards += 1
            # reset
            time_to_first_kill = nil
            total_kills = 0
          end
        else
          # reset
          time_to_first_kill = nil
          total_kills = 0
        end
      end

      player.awards += awards
    end
  end

  def generate_player_rankings(match)
    valid_players = match.players.delete_if {|player| player.world? }
    @players = valid_players.sort_by { |player| player.kills }.reverse!
  end

end
