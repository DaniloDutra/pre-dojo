class Match
  attr_reader :id, :created_at, :events, :players

  def initialize(id, created_at)
    @id = id
    @created_at = created_at
    @events = []
    @players = []
  end

  def add_event(event)
    from_player = find_player(event[:from_player]) || create_player(event[:from_player])
    to_player = find_player(event[:to_player]) || create_player(event[:to_player])

    event = Event.new(from_player, to_player, event[:weapon], event[:created_at])
    @events << event
  end

  def player_rankings
    valid_players = @players.delete_if {|player| player.world? }
    valid_players.sort_by { |player| player.kills }.reverse!
  end

  def winner
    rankings = player_rankings
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

  private

  def find_player(name)
    @players.find {|player| player.name == name }
  end

  def create_player(name)
    player = Player.new(name)
    @players << player
    player
  end
end
