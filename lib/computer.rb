class Computer
  def initialize(args)
    @guess_evaluator = args[:guess_evaluator]
    @raw_guess = [0, 0, 0, 0]
    @previous_evaluation = { color_and_spot: -1 }
    @current_evaluation = { color_and_spot: -1 }
    @current_column = 0
  end

  def input
    guess = _convert_raw_guess if _current_evaluation == -1
    @current_column += 1 if _current_evaluation == (_previous_evaluation + 1) && _previous_evaluation != -1
    if @raw_guess[@current_column] == 2 && _current_evaluation != 0 && !(_previous_evaluation > _current_evaluation)
      @raw_guess[@current_column] += 1
      unless @current_column == 3
        @current_column += 1
        @raw_guess[@current_column] += 1
        @current_evaluation[:color_and_spot] += 1
      end
      guess = _convert_raw_guess
    end
    unless guess || _current_evaluation != 0 || @raw_guess.uniq.size != 1
      @raw_guess = @raw_guess.map { |element| element + 1 }
      guess = _convert_raw_guess
    end
    unless guess || _current_evaluation == 4
      if _previous_evaluation >_current_evaluation 
        @raw_guess[@current_column] -= 1
        @current_column += 1
        @current_evaluation[:color_and_spot] += 1
      end
      @raw_guess[@current_column] += 1 unless _current_evaluation == 4
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

  def _current_evaluation
    @current_evaluation[:color_and_spot]
  end

  def _previous_evaluation
    @previous_evaluation[:color_and_spot]
  end
end
