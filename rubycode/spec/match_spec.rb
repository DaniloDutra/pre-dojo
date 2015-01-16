require "match"
require "event"
require "player"

describe Match do
  before do
    @match = Match.new "1", Time.now
  end

  describe "#add_event" do
    before do
      @match.add_event(event)
    end

    it "should add an event" do
      expect(@match.events.size).to eq(1)
      expect(@match.players.size).to eq(2)
    end

    it "should not duplicate players" do
      @match.add_event(event(to_player: "Nick"))
      expect(@match.events.size).to eq(2)
      expect(@match.players.size).to eq(3)
    end
  end

  def event(attrs = {})
    { match: "1", from_player: "verto", to_player: "noob", weapon: "AWP", created_at: Time.now }.merge!(attrs)
  end
end
