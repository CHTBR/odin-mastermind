class Computer
  def initialize(args)
    @guess_evaluator = args[:guess_evaluator]
    @raw_guess = [0, 0, 0, 0]
    @previous_evaluation = { color_and_spot: -1 }
    @current_evaluation = { color_and_spot: -1 }
    @current_column = 0
  end

  def input
    guess = _convert_raw_guess if @current_evaluation[:color_and_spot] == -1
    @current_column += 1 if @current_evaluation[:color_and_spot] > @previous_evaluation[:color_and_spot] && @previous_evaluation[:color_and_spot] != -1
    if @raw_guess[@current_column] == 2 && @current_evaluation[:color_and_spot] != 0
      @raw_guess[@current_column] += 1
      @current_column += 1
      @raw_guess[@current_column] += 1
      @current_evaluation[:color_and_spot] += 1
      guess = _convert_raw_guess
    end
    unless guess || @current_evaluation[:color_and_spot] != 0
      @raw_guess = @raw_guess.map { |element| element + 1 }
      guess = _convert_raw_guess
    end
    unless guess || @current_evaluation[:color_and_spot] == 4
      if @previous_evaluation[:color_and_spot] > @current_evaluation[:color_and_spot]
        @raw_guess[@current_column] -= 1
        @current_column += 1
        @current_evaluation[:color_and_spot] += 1
      end
      @raw_guess[@current_column] += 1
      guess = _convert_raw_guess
    end
    guess = _convert_raw_guess
    @previous_evaluation = @current_evaluation
    @current_evaluation = @guess_evaluator.evaluate_guess(guess)
    guess
  end

  def _convert_raw_guess
    options = %i[red green blue yellow]
    Array.new(4).map.with_index { |_element, index| options[@raw_guess[index]] }
  end
end
