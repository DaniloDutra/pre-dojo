require "player"
require "event"
require "awards"

describe Awards do

  before do
    @players = {}
    @player = Player.new 'player'
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

  describe "#calculate_winner_awards" do
    it "should add awards if has deaths" do
      allow(@player).to receive(:deaths) { 0 }
      Awards.new(@player).calculate_winner_awards

      expect(@player.awards).to eq(1)
    end

    it "should not add awards if has deaths" do
      allow(@player).to receive(:deaths) { 1 }
      Awards.new(@player).calculate_winner_awards

      expect(@player.awards).to eq(0)
    end
  end

  describe "#calculate_kills_awards" do
    before do
      @next_date = Time.now + 61
      event(from_player: @player)
      event(from_player: @player, created_at: @next_date)
      event(from_player: @player, created_at: @next_date)
      event(from_player: @player, created_at: @next_date)
      event(from_player: @player, created_at: @next_date)
    end

    it "should add awards if player has 5 kills in 1 minute" do
      event(from_player: @player, created_at: @next_date)
      Awards.new(@player).calculate_kills_awards
      expect(@player.awards).to eq(1)
    end

    it "should not add awards if player haven't 5 kills in 1 minute" do
      Awards.new(@player).calculate_kills_awards
      expect(@player.awards).to eq(0)
    end
  end
end
