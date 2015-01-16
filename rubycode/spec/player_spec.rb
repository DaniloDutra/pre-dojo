require "player"

describe Player do
  before do
    @player = Player.new("Nick")
    @player.add_event(event(@player))
    @player.add_event(event(@player))
    @player.add_event(event(nil,@player))
  end

  def event(from_player, to_player= nil)
    event = double("event", from_player: (from_player || double('player')), to_player: to_player || double('player'))
  end

  it "should return totals of kills" do
    expect(@player.kills).to eq(2)
  end

  it "should return total of deaths" do
    expect(@player.deaths).to eq(1)
  end
end
