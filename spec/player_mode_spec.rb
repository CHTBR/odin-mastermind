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
    @player_mode = PlayerMode.new({ input_manager: @player_double, board: @board_double, guess_evaluator: @guess_evaluator })
  end
end
