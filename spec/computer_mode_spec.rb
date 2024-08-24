require "rspec"
require_relative "../lib/computer_mode"
require_relative "startable_spec"
require_relative "../lib/board"
require_relative "../lib/guess_evaluator"

RSpec.describe ComputerMode do
  before do
    @guess_evaluator_double = instance_double("GuessEvaluator")
    allow(@guess_evaluator_double).to receive(:target=)
    @board_double = instance_double("Board")
    allow(@board_double).to receive(:target=)
    @computer_double = double("Computer")
    allow(@computer_double).to receive(:guess)
    @computer_mode = ComputerMode.new({ guess_evaluator: @guess_evaluator_double, board: @board_double,
                                        computer: @computer_double })
  end

  it_behaves_like "a startable" do
    subject { @computer_mode }
  end

  context "during pre-game configuration" do
    it "generates a target sequence and gives it to the guess_evaluator" do
      expect(@guess_evaluator_double).to receive(:target=)
      @computer_mode.start
    end

    xit "gives sequence to the board" do
      expect(@board_double).to receive(:target=)
      @computer_mode.start
    end
  end

  context "during the full game consisting of at most 12 rounds" do
    context "when a computer doesn't guess the correct sequence" do
      before do
        allow(@input_manager_double).to receive(:evaluate_guess).and_return({ color: 0, color_and_spot: 0 })
      end

      xit "sends a message to ask the computer for a guess every round and no more" do
        allow(@computer).to receive(:input)
        @computer_mode.start
        expect(@computer).to have_received(:input).exactly(12).times
      end
      xit "sends a message to update board every round" do
        allow(@board).to receive(:set_column)
        @computer_mode.start
        expect(@board).to have_received(:set_column).exactly(12).times
      end
    end

    context "when a computer wins in the 7th round of the game" do
      before do
        allow(@input_manager_double).to receive(:evaluate_guess).and_return({ color: 0, color_and_spot: 0 },
                                                                            { color: 0, color_and_spot: 0 }, { color: 0, color_andspot: 0 }, { color: 0, color_and_spot: 0 }, { color: 0, color_and_spot: 0 }, { color: 0, color_and_spot: 0 }, { color: 0, color_and_spot: 4 })
      end

      xit "sends a message to ask the computer for a guess every round and no more" do
        allow(@computer).to receive(:input)
        @computer_mode.start
        expect(@computer).to have_received(:input).exactly(7).times
      end

      xit "sends a message to update board every round" do
        allow(@board).to receive(:input)
        @computer_mode.start
        expect(@board).to have_received(:input).exactly(7).times
      end
    end
  end
end
