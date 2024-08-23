require "rspec"
require_relative "../lib/computer_mode"
require_relative "startable_spec"
require_relative "../lib/board"
require_relative "../lib/guess_evaluator"

RSpec.describe ComputerMode do
  before do
    guess_evaluator_double = instance_double("GuessEvaluator")
    board_double = instance_double("Board")
    computer_double = double("Computer")
    allow(computer_double).to receive(:guess)
    computer_mode = ComputerMode.new({ guess_evaluator: guess_evaluator_double, board: board_double,
                                       computer: computer_double })
  end

  it_behaves_like "a startable" do
    subject { ComputerMode.new({ guess_evaluator: "", board: "", computer: "" }) }
  end
end
