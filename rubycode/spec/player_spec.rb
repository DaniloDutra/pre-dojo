require "player"

describe Player do
  before do
    @player = Player.new("Nick")
    @player.add_event(event(from_player: @player))
    @player.add_event(event(from_player: @player))
    @player.add_event(event(to_player: @player))
  end

  def event(attrs={})
   current_attrs = {
          from_player: double('player'),
          to_player: double('player'),
          weapon: "AWP",
          created_at: Time.now }

    double('event', current_attrs.merge!(attrs))
  end

  it "should return totals of kills" do
    expect(@player.kills).to eq(2)
  end

  it "should return total of deaths" do
    expect(@player.deaths).to eq(1)
  end

  describe "#add_event" do
    it "should sort by created_at" do
      expected_created_at = Time.now - 60
      @player.add_event(event(from_player: "LastUser", created_at: expected_created_at))
      expect(@player.events.first.created_at).to eq(expected_created_at)
    end
  end

  describe "favorite weapon" do
    before do
      @player.add_event(event(from_player: @player, weapon: "USP"))
      @player.add_event(event(from_player: @player, weapon: "USP"))
      @player.add_event(event(from_player: @player, weapon: "USP"))
    end

    it "should return favorite weapon" do
      expect(@player.favorite_weapon).to eq("USP")
    end

    it "should return first favorite weapon if has more than one" do
      @player.add_event(event(from_player: @player, weapon: "AWP"))
      expect(@player.favorite_weapon).to eq("USP")
    end
  end

  describe "#killstreak" do
    before do
      @player = Player.new("NickKiller")
    end

    it "should return better seq of kills" do
      @player.add_event(event(from_player: @player))
      @player.add_event(event(to_player: @player))
      @player.add_event(event(from_player: @player))
      @player.add_event(event(from_player: @player))
      @player.add_event(event(from_player: @player))
      @player.add_event(event(to_player: @player))

      expect(@player.killstreak).to eq(3)
    end

    it "should return 0 if haven't kills" do
      @player.add_event(event(to_player: @player))
      expect(@player.killstreak).to eq(0)
    end
  end
end
