class Player
  attr_reader :name

  WORLD_NAME = "<WORLD>"

  def initialize(name)
    @name = name
    @events = []
    @weapons = {}
  end

  def add_event(event)
    @events << event
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

  private

  def load_stats
    unless @stats_loaded
      @kills,@deaths = 0,0
      @weapons = {}

      @events.each do |event|
        if self == event.from_player
          @kills += 1
          @weapons[event.weapon] ||= 0
          @weapons[event.weapon] += 1
        end
        @deaths += 1 if self == event.to_player
      end
      @stats_loaded = true
    end
  end
end
