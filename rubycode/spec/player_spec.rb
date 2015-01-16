require "player"

describe Player do
  before do
    @player = Player.new("Nick")
    @player.add_event(event(@player))
    @player.add_event(event(@player))
    @player.add_event(event(nil,@player))
  end

  def event(from_player, to_player= nil, weapon = "AWP")
    event = double("event", from_player: (from_player || double('player')), to_player: to_player || double('player'), weapon: weapon)
  end

  it "should return totals of kills" do
    expect(@player.kills).to eq(2)
  end

  it "should return total of deaths" do
    expect(@player.deaths).to eq(1)
  end

  describe "favorite weapon" do
    before do
      @player.add_event(event(@player, nil, "USP"))
      @player.add_event(event(@player, nil, "USP"))
      @player.add_event(event(@player, nil, "USP"))
    end

    it "should return favorite weapon" do
      expect(@player.favorite_weapon).to eq("USP")
    end

    it "should return first favorite weapon if has more than one" do
      @player.add_event(event(@player, nil, "AWP"))
      expect(@player.favorite_weapon).to eq("USP")
    end
  end
end
