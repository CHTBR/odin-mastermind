class GuessEvaluator
  attr_accessor :target

  def evaluate_guess(guesses)
    evaluation = { color_and_spot: 0, color: 0 }
    target.each_with_index { |target_entry, index| evaluation[:color_and_spot] += 1 if guesses[index] == target_entry }
    guesses.each do |guess|
      if target.include?(guess)
        evaluation[:color] += 1
        target.delete_at(target.index(guess))
      end
    end
    evaluation[:color] = evaluation[:color] - evaluation[:color_and_spot]
    evaluation
  end
end
