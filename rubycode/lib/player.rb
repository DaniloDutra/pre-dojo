class Player
  attr_reader :name

  WORLD_NAME = "<WORLD>"

  def initialize(name)
    @name = name
    @events = []
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

  private

  def load_stats
    unless @stats_loaded
      @kills,@deaths = 0,0
      @events.each do |event|
        @kills += 1 if self == event.from_player
        @deaths += 1 if self == event.to_player
      end
      @stats_loaded = true
    end
  end
end
