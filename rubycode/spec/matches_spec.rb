require "match"
require "player"
require "event"
require "matches"

describe Matches do
  before do
    parser = double 'parser'
    allow(parser).to receive(:datatable){ expected_datatable }
    @matches = Matches.new parser
  end

  def expected_datatable
    [
      { match_id: "1", from_player: "verto", to_player: "noob", weapon: "AWP" },
      { match_id: "1", from_player: "<WORLD>", to_player: "verto", weapon: "DROWN" },
      { match_id: "2", from_player: "noob", to_player: "verto", weapon: "USP" }
    ]
  end

  it "all matches" do
    expect(@matches.all.size).to eq(2)
  end
end
