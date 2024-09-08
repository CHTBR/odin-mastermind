require "rspec"
require_relative "../lib/computer_mode"
require_relative "startable_spec"
require_relative "../lib/board"
require_relative "../lib/guess_evaluator"
require_relative "../lib/player"

RSpec.describe ComputerMode do
  before do
    @input_manager_double = instance_double("Player")
    allow(@input_manager_double).to receive(:input).and_return("target")
    @guess_evaluator_double = instance_double("GuessEvaluator")
    allow(@guess_evaluator_double).to receive(:target=)
    allow(@guess_evaluator_double).to receive(:evaluate_guess).and_return({ color: 0, color_and_spot: 0 })
    @board_double = instance_double("Board")
    allow(@board_double).to receive(:target=)
    allow(@board_double).to receive(:set_column)
    @computer_double = double("Computer")
    allow(@computer_double).to receive(:guess)
    allow(@computer_double).to receive(:input)
    @computer_mode = ComputerMode.new({ guess_evaluator: @guess_evaluator_double, board: @board_double,
                                        computer: @computer_double, input_manager: @input_manager_double })
  end

  it_behaves_like "a startable" do
    subject { @computer_mode }
  end

  describe "#to_s" do
    it "implements a custom #to_s method" do
      expect(@computer_mode.to_s).to eql("Computer Mode")
    end
  end

  context "during pre-game configuration" do
    it "asks the input_manager for a target" do
      expect(@input_manager_double).to receive(:input).with({ message: "Choose a color:", options: %i[red green blue yellow] }).exactly(4).times
      @computer_mode.start
    end

    it "gives the target to the guess_evaluator" do
      expect(@guess_evaluator_double).to receive(:target=)
      @computer_mode.start
    end

    it "gives the target to the board" do
      expect(@board_double).to receive(:target=)
      @computer_mode.start
    end
  end

  context "during the full game consisting of at most 12 rounds" do
    context "when a computer doesn't guess the correct sequence" do
      before do
        allow(@computer_double).to receive(:input).and_return("board")
        allow(@guess_evaluator_double).to receive(:evaluate_guess).and_return({ color: 0, color_and_spot: 0 })
      end

      it "sends a message to ask the computer for a guess every round and no more" do
        @computer_mode.start
        expect(@computer_double).to have_received(:input).exactly(12).times
      end
      it "sends a message to ask the guess_evaluator for a guess evaluation every round and no more" do
        @computer_mode.start
        expect(@guess_evaluator_double).to have_received(:evaluate_guess).with("board").exactly(12).times
      end
      it "sends a message to update board every round" do
        @computer_mode.start
        expect(@board_double).to have_received(:set_column).exactly(12).times
      end
    end

    context "when a computer wins in the 7th round of the game" do
      before do
        allow(@computer_double).to receive(:input).and_return("board2")
        allow(@guess_evaluator_double).to receive(:evaluate_guess).and_return({ color: 0, color_and_spot: 0 },
                                                                              { color: 0, color_and_spot: 0 }, { color: 0, color_andspot: 0 }, { color: 0, color_and_spot: 0 }, { color: 0, color_and_spot: 0 }, { color: 0, color_and_spot: 0 }, { color: 0, color_and_spot: 4 })
      end

      it "sends a message to ask the computer for a guess every round and no more" do
        @computer_mode.start
        expect(@computer_double).to have_received(:input).exactly(7).times
      end
      it "sends a message to ask the guess_evaluator for a guess evaluation every round and no more" do
        @computer_mode.start
        expect(@guess_evaluator_double).to have_received(:evaluate_guess).with("board2").exactly(7).times
      end
      it "sends a message to update board every round" do
        @computer_mode.start
        expect(@board_double).to have_received(:set_column).exactly(7).times
      end
    end
  end
end
