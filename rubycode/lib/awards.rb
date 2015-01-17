class Awards
  TOTAL_KILLS_TO_AWARDS = 5
  MAX_SECONDS_TO_KILLS = 60

  def initialize(player)
    @player = player
  end

  def calculate_winner_awards
    @player.awards += 1 if @player.deaths == 0
  end

  def calculate_kills_awards
    start_kills_date = nil
      total_kills, awards = 0,0
      @player.events.each do |event|
        if event.is_a_kill_of?(@player)

          start_kills_date ||= event.created_at
          time_limit = start_kills_date + MAX_SECONDS_TO_KILLS
          total_kills += 1 if event.created_at <= time_limit

          if total_kills == TOTAL_KILLS_TO_AWARDS
            awards += 1
            # reset
            start_kills_date = nil
            total_kills = 0
          elsif event.created_at > time_limit
            start_kills_date = event.created_at
            total_kills = 1
          end
        else
          # reset
          start_kills_date = nil
          total_kills = 0
        end
      end

      @player.awards += awards
  end

end
