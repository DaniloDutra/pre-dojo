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

  describe "#winner" do
    before do
      @match.add_event(event)
      @match.add_event(event(to_player: "Nick", weapon: "USP"))
      @match.add_event(event(to_player: "Roman", weapon: "USP"))
      @match.add_event(event(from_player: "Roman", to_player: "verto", weapon: "USP"))
    end

    it "should return winner of match" do
      winner = @match.winner
      expect(winner.name).to eq("verto")
    end

    it "should return nil if has a draw" do
      @match.add_event(event(from_player: "Roman", to_player: "Nick", weapon: "USP"))
      @match.add_event(event(from_player: "Roman", to_player: "verto", weapon: "AWP"))
      expect(@match.winner).to eq(nil)
    end
  end

  def event(attrs = {})
    { match: "1", from_player: "verto", to_player: "noob", weapon: "AWP", created_at: Time.now }.merge!(attrs)
  end
end
