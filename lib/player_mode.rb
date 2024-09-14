class PlayerMode
  def initialize(args)
    @guess_evaluator = args[:guess_evaluator]
    @input_manager = args[:input_manager]
    @board = args[:board]
  end

  def start
    @guess_evaluator.target = Array.new(4) { %i[red green blue yellow].shuffle.shuffle.sample } # Use multiple shuffles to increase randomness
    round = 0
    until round == 12
      guess = _player_guess
      evaluation = @guess_evaluator.evaluate_guess(guess)
      @board.set_column({ number: round, sequence: guess })
      round += 1
      break if _won?(evaluation)
    end
  end

  def to_s
    "Player Mode"
  end

  def _player_guess
    Array.new(4) { @input_manager.input({ message: "Choosea color:", options: %i[red green blue yellow] }) }
  end

  def _won?(evaluation)
    evaluation[:color_and_spot] == 4
  end
end
