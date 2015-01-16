class Matches
  def initialize(parser = LogParser.new)
    @matches = []
    events = parser.datatable
    events.each do |event|
      match = find(event[:match_id])

      if match.nil?
        match = Match.new(event[:match_id], event[:match_created_at])
        @matches << match
      end

      match.add_event(event)
    end
  end

  def all
    @matches
  end

  def find(id)
    @matches.find {|match| match.id == id }
  end

end
