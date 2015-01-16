require "match"
require "player"
require "event"
require "ranking"

describe Ranking do
  before do
    @match = Match.new "1", Time.now
  end

  describe "#winner" do
    before do
      add_match_event(@match)
      add_match_event(@match, to_player: "Nick", weapon: "USP")
      add_match_event(@match, to_player: "Roman", weapon: "USP")
      add_match_event(@match, from_player: "Roman", to_player: "verto", weapon: "USP")
    end

    it "should return winner of match" do
      rank = Ranking.new(@match)
      winner = rank.winner
      expect(winner.name).to eq("verto")
    end

    it "should return nil if has a draw" do
      add_match_event(@match, from_player: "Roman", to_player: "Nick", weapon: "USP")
      add_match_event(@match, from_player: "Roman", to_player: "verto", weapon: "AWP")

      rank = Ranking.new(@match)
      expect(rank.winner).to eq(nil)
    end
  end

  def add_match_event(match, attrs = {})
    match.add_event({ from_player: "verto", to_player: "noob", weapon: "AWP", created_at: Time.now }.merge!(attrs))
  end
end
