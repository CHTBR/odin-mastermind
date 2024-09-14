require "rspec"
require_relative "startable_spec"
require_relative "../lib/player_mode"
require_relative "../lib/player"
require_relative "../lib/board"
require_relative "../lib/guess_evaluator"

RSpec.describe PlayerMode do
  before do
    @player_double = instance_double("Player")
    @board_double = instance_double("Board")
    @guess_evaluator_double = instance_double("GuessEvaluator")
    @player_mode = PlayerMode.new({ input_manager: @player_double, board: @board_double, guess_evaluator: @guess_evaluator_double })
  end

  it_behaves_like "a startable" do
    subject { @player_mode }
  end

  describe "#to_s" do
    it "returns Player Mode" do
      expect(@player_mode.to_s).to eql("Player Mode")
    end
  end

  context "during pre-game configuration" do
    it "generates a random target and gives it to the guess_evaluator" do
      expect(@guess_evaluator_double).to receive(:target=)
      @player_mode.start
    end
  end
end
