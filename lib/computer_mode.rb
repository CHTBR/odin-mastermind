class ComputerMode
  def initialize(args)
    @guess_evaluator = args[:guess_evaluator]
    @board = args[:board]
    @computer = args[:computer]
  end

  def start
    target = _generate_randomized_target_sequence
    @guess_evaluator.target = target
    @board.target = target
    _start_game_loop
  end

  def _generate_randomized_target_sequence
    Array.new(4).map { |_element| %i[red green red yellow].shuffle.shuffle.sample }
  end

  def _start_game_loop
    12.times do
      guess = @computer.input
      evaluation = @guess_evaluator.evaluate_guess(guess)
      @board.set_column(guess)
      break if evaluation[:color_and_spot] == 4
    end
  end
end
