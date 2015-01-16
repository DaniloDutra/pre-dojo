class Match
  attr_reader :id, :created_at, :events, :players, :player_rankings

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
