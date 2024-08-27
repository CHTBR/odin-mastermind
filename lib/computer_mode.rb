class ComputerMode
  def initialize(args)
    @guess_evaluator = args[:guess_evaluator]
    @board = args[:board]
    @computer = args[:computer]
    @input_manager = args[:input_manager]
  end

  def start
    target = []
    4.times { target << @input_manager.input({ message: "Choose a color:", options: %i[red green blue yellow] }) }
    @guess_evaluator.target = target
    @board.target = target
    puts @board
    _start_game_loop
  end

  def _start_game_loop
    12.times do |number|
      guess = @computer.input
      evaluation = @guess_evaluator.evaluate_guess(guess)
      @board.set_column({ number: number, sequence: guess })
      puts @board
      puts "The computer guessed #{evaluation[:color_and_spot]} pins exactly and got #{evaluation[:color]} colors right"
      if evaluation[:color_and_spot] == 4
        puts "The computer guessed the sequence in #{number + 1} turns."
        return
      end
    end
    puts "The computer didn't manage to guess the sequence."
  end
end
