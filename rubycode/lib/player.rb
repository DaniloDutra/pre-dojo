class Player
  attr_reader :name, :events
  attr_accessor :awards

  WORLD_NAME = "<WORLD>"

  def initialize(name)
    @name = name
    @events = []
    @weapons = {}
    @awards = 0
  end

  def add_event(event)
    @events << event
    @events.sort_by! { |event| event.created_at }
  end

  def kills
    load_stats
    @kills
  end

  def deaths
    load_stats
    @deaths
  end

  def world?
    WORLD_NAME.eql?(name)
  end

  def favorite_weapon
    load_stats
    weapon = @weapons.sort_by{ |k,v| v }.reverse!.first
    weapon ? weapon[0] : nil
  end

  def killstreak
    load_stats
    @killstreak
  end

  private

  def load_stats
    unless @stats_loaded
      @kills,@deaths,@killstreak = 0,0,0
      @weapons = {}

      streak = 0
      @events.each do |event|
        if self == event.from_player
          @kills += 1
          streak += 1
          @weapons[event.weapon] ||= 0
          @weapons[event.weapon] += 1
        elsif self == event.to_player
          @deaths += 1
          update_killstreak streak
          streak = 0
        end
      end

      update_killstreak streak

      @stats_loaded = true
    end
  end

  def update_killstreak(kills)
    @killstreak = kills if kills > @killstreak
  end
end
