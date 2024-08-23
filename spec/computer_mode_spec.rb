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
    xit "generates a target sequence and gives it to the guess_evaluator" do
      expect(@guess_evaluator_double).to receive(:target=)
      @computer_mode.start
    end
  end
end
