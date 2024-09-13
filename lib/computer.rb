class Computer
  def initialize(args)
    @guess_evaluator = args[:guess_evaluator]
    @raw_guess = [0, 0, 0, 0]
    @previous_evaluation = { color_and_spot: -1 }
    @current_evaluation = { color_and_spot: -1 }
    @current_column = 0
  end

  def input
    # on first pass
    guess = _convert_raw_guess if _current_evaluation == -1
    # if we got the option right in this column and this is not one of the first two guesses
    @current_column += 1 if _current_evaluation == (_previous_evaluation + 1) && _previous_evaluation != -1
    # if we're on the one before last option and our current evaluation isn't 0 and our evaluation isn't incorrect
    if @raw_guess[@current_column] == 2 && _current_evaluation != 0 && _previous_evaluation <= _current_evaluation
      _skip_last_option_and_move_to_next_column
      guess = _convert_raw_guess
    end
    # unless there's already a guess or or our current evaluation isn't 0 or all the columns don't have the same option
    unless guess || _current_evaluation != 0 || @raw_guess.uniq.size != 1
      _increment_all_columns
      guess = _convert_raw_guess
    end
    # unless there's already a guess and we don't have the correct guess yet
    _evaluate_current_column unless guess || _current_evaluation == 4
    guess = _convert_raw_guess
    _evaluate_guess(guess)
    guess
  end

  def _skip_last_option_and_move_to_next_column
    @raw_guess[@current_column] += 1
    # if we aren't in the last column
    return if @current_column == 3
    @current_column += 1
    @raw_guess[@current_column] += 1
    @current_evaluation[:color_and_spot] += 1
  end

  def _increment_all_columns
    @raw_guess = @raw_guess.map { |element| element + 1 }
  end

  def _evaluate_current_column
    # if our evaluation isn't incorrect
    if _previous_evaluation > _current_evaluation
      @raw_guess[@current_column] -= 1
      @current_column += 1
      @current_evaluation[:color_and_spot] += 1
    end
    @raw_guess[@current_column] += 1 unless _current_evaluation == 4
  end

  def _evaluate_guess(guess)
    @previous_evaluation = @current_evaluation
    @current_evaluation = @guess_evaluator.evaluate_guess(guess)
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
