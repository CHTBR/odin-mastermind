class Computer
  def initialize(args)
    @guess_evaluator = args[:guess_evaluator]
    @raw_guess = [0, 0, 0, 0]
    @previous_evaluation = nil
  end

  def input
    guess = _convert_raw_guess unless @previous_evaluation
    @previous_evaluation = @guess_evaluator.evaluate_guess(guess)
    guess
  end

  def _convert_raw_guess
    options = %i[red green blue yellow]
    Array.new(4).map.with_index { |_element, index| options[@raw_guess[index]] }
  end
end
