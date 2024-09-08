class ComputerMode
  def initialize(args)
    @guess_evaluator = args[:guess_evaluator]
    @board = args[:board]
    @computer = args[:computer]
    @input_manager = args[:input_manager]
  end

  def start
    target = _request_target
    @guess_evaluator.target = target
    @board.target = target
    puts @board # Print the initial board layout to the player
    _start_game_loop
  end

  def _request_target
    target = []
    4.times { target << @input_manager.input({ message: "Choose a color:", options: %i[red green blue yellow] }) }
    target
  end

  def _start_game_loop
    12.times do |number|
      guess = _request_guess
      evaluation = _request_guess_evaluation(guess)
      _update_board(guess, number)
      _print_evaluation_message(evaluation)
      return if _won?(evaluation, number)
    end
    puts "The computer didn't manage to guess the sequence."
  end

  def _request_guess
    @computer.input
  end

  def _request_guess_evaluation(guess)
    @guess_evaluator.evaluate_guess(guess)
  end

  def _update_board(guess, round)
    @board.set_column({ number: round, sequence: guess })
  end

  def _print_evaluation_message(evaluation)
    puts @board
    puts "The computer guessed #{evaluation[:color_and_spot]} pins exactly and got #{evaluation[:color]} colors right"
  end

  def _won?(evaluation, round)
    return false unless evaluation[:color_and_spot] == 4

    puts "The computer guessed the sequence in #{round + 1} turns."
    true
  end

  def to_s
    "Computer Mode"
  end
end
