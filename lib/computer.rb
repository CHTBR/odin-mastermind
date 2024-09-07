class Computer
  def initialize(args)
    @guess_evaluator = args[:guess_evaluator]
    @raw_guess = [0, 0, 0, 0]
    @current_evaluation = {}
    @current_column = 0
  end

  def input
    guess = _convert_raw_guess unless @current_evaluation[:color_and_spot]
    unless guess || @current_evaluation[:color_and_spot] != 0
      @raw_guess = @raw_guess.map { |element| element + 1 }
      guess = _convert_raw_guess
    end
    unless guess || @current_evaluation[:color_and_spot] == 4
      @raw_guess[@current_column] += 1
      guess = _convert_raw_guess
    end
    guess = _convert_raw_guess
    @current_evaluation = @guess_evaluator.evaluate_guess(guess)
    guess
  end

  def _convert_raw_guess
    options = %i[red green blue yellow]
    Array.new(4).map.with_index { |_element, index| options[@raw_guess[index]] }
  end
end
