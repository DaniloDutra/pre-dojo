class Event
  attr_reader :from_player, :to_player, :weapon, :created_at

  def initialize(from_player, to_player, weapon, created_at)
    @from_player = from_player
    @to_player = to_player
    @weapon = weapon
    @created_at = created_at

    @to_player.add_event(self)
    @from_player.add_event(self)
  end

  def is_a_kill_of?(player)
    player == from_player
  end

  def is_a_death_of?(player)
    player == to_player
  end
end
