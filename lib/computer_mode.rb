class ComputerMode
  def initialize(args)
    @guess_evaluator = args[:guess_evaluator]
    @board = args[:board]
    @computer = args[:computer]
  end

  def start
    target = Array.new(4).map { |_element| %i[red green red yellow].shuffle.shuffle.sample }
    @guess_evaluator.target = target
    @board.target = target

    12.times do
      @computer.input
      evaluation = @guess_evaluator.evaluate_guess("board")
      @board.set_column("board")
      break if evaluation[:color_and_spot] == 4
    end
  end
end
