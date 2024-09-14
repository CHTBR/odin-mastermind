require "rspec"
require_relative "startable_spec"
require_relative "../lib/player_mode"
require_relative "../lib/player"
require_relative "../lib/board"
require_relative "../lib/guess_evaluator"

RSpec.describe PlayerMode do
  before do
    @player_double = instance_double("Player")
    allow(@player_double).to receive(:input).and_return("target")
    @board_double = instance_double("Board")
    allow(@board_double).to receive(:target=)
    allow(@board_double).to receive(:set_column)
    @guess_evaluator_double = instance_double("GuessEvaluator")
    allow(@guess_evaluator_double).to receive(:target=)
    allow(@guess_evaluator_double).to receive(:evaluate_guess).and_return({ color: 0, color_and_spot: 0 })
    @player_mode = PlayerMode.new({ input_manager: @player_double, board: @board_double,
                                    guess_evaluator: @guess_evaluator_double })
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

  context "during a full game consisting of at most 12 rounds" do
    context "when the player doesn't guess the correct sequence" do
      before do
        allow(@guess_evaluator_double).to receive(:evaluate_guess).and_return({ color: 0, color_and_spot: 0 })
        allow(@player_double).to receive(:input).and_return("board")
      end

      it "sends a message to ask the player for a guess every round and no more" do
        @player_mode.start
        expect(@player_double).to have_received(:input).exactly(4 * 12).times # 4 times the number of rounds - one for every color
      end

      it "sends a message to ask the guess_evaluator for a guess evaluation every round and no more" do
        @player_mode.start
        expect(@guess_evaluator_double).to have_received(:evaluate_guess).with(%w[board board board board]).exactly(12).times
      end

      it "sends a message to update board every round" do
        @player_mode.start
        expect(@board_double).to have_received(:set_column).exactly(12).times
      end
    end

    context "when a player wins in the 7th round of the game" do
      before do
        allow(@player_double).to receive(:input).and_return("board2")
        allow(@guess_evaluator_double).to receive(:evaluate_guess).and_return({ color: 0, color_and_spot: 0 },
                                                                              { color: 0, color_and_spot: 0 },
                                                                              { color: 0, color_and_spot: 0 },
                                                                              { color: 0, color_and_spot: 0 },
                                                                              { color: 0, color_and_spot: 0 },
                                                                              { color: 0, color_and_spot: 0 },
                                                                              { color: 0, color_and_spot: 4 })
      end

      it "sends a message to ask the player for a guess every round and no more" do
        @player_mode.start
        expect(@player_double).to have_received(:input).exactly(4 * 7).times # 4 times the number of rounds - one for every color
      end

      it "sends a message to ask the guess_evaluator for a guess evaluation every round and no more" do
        @player_mode.start
        expect(@guess_evaluator_double).to have_received(:evaluate_guess).with(%w[board2 board2 board2 board2]).exactly(7).times
      end

      it "sends a message to update board every round" do
        @player_mode.start
        expect(@board_double).to have_received(:set_column).exactly(7).times
      end
    end
  end
end
