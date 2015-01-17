require "player"
require "event"

describe Player do
  before do
    @players = {}
    @player = player("Nick")
    event(from_player: @player)
    event(from_player: @player)
    event(to_player: @player)
  end

  def event(attrs={})
   current_attrs = {
          from_player: player('player1'),
          to_player: player('player2'),
          weapon: "AWP",
          created_at: Time.now }

   current_attrs = current_attrs.merge!(attrs)

    Event.new current_attrs[:from_player],
              current_attrs[:to_player],
              current_attrs[:weapon],
              current_attrs[:created_at]
  end

  def player(name)
    @players[name] ||= Player.new(name)
    @players[name]
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
      event(from_player: player("LastUser"), to_player: @player, created_at: expected_created_at)
      expect(@player.events.first.created_at).to eq(expected_created_at)
    end
  end

  describe "favorite weapon" do
    before do
      event(from_player: @player, weapon: "USP")
      event(from_player: @player, weapon: "USP")
      event(from_player: @player, weapon: "USP")
    end

    it "should return favorite weapon" do
      expect(@player.favorite_weapon).to eq("USP")
    end

    it "should return first favorite weapon if has more than one" do
      event(from_player: @player, weapon: "AWP")
      expect(@player.favorite_weapon).to eq("USP")
    end
  end

  describe "#killstreak" do
    before do
      @player = player("NickKiller")
    end

    it "should return better seq of kills" do
      event(from_player: @player)
      event(to_player: @player)
      event(from_player: @player)
      event(from_player: @player)
      event(from_player: @player)
      event(to_player: @player)

      expect(@player.killstreak).to eq(3)
    end

    it "should return 0 if haven't kills" do
      event(to_player: @player)
      expect(@player.killstreak).to eq(0)
    end
  end
end
