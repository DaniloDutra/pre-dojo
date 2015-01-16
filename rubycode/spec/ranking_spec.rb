require "match"
require "player"
require "event"
require "ranking"

describe Ranking do
  before do
    @match = Match.new "1", Time.now
    add_match_event(@match)
    add_match_event(@match, to_player: "Nick", weapon: "USP")
    add_match_event(@match, to_player: "Roman", weapon: "USP")
  end

  describe "#winner" do
    before do
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

  describe "generate awards" do
    it "should add award to winner without deaths" do
      rank = Ranking.new(@match)
      winner = rank.winner
      expect(winner.awards).to eq(1)
      expect(rank.players.last.awards).to eq(0)
    end

    describe "generate awards by kills" do
      before do
        add_match_event(@match, to_player: "Nick", weapon: "AWP")
      end

      it "should add award to player that kill more than 5x in one minute" do
        add_match_event(@match, to_player: "Nick", weapon: "AWP")
        rank = Ranking.new(@match)
        expect(rank.winner.awards).to eq(2)
      end
      
      it "should not add award to player that kill 5x in more then one minute" do
        add_match_event(@match, to_player: "Nick", weapon: "AWP", created_at: Time.now + 301)
        rank = Ranking.new(@match)
        expect(rank.winner.awards).to eq(1)
      end
    end
  end

  def add_match_event(match, attrs = {})
    match.add_event({ from_player: "verto", to_player: "noob", weapon: "AWP", created_at: Time.now }.merge!(attrs))
  end
end
