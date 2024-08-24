class GuessEvaluator
  attr_accessor :target

  def evaluate_guess(guesses)
    @temporary_target = Array.new(target)
    evaluation = { color_and_spot: 0, color: 0 }
    _find_all_color_and_spot_matches(evaluation, guesses)
    _find_all_color_matches(evaluation, guesses)
    _remove_duplicate_color_matches(evaluation)
    evaluation
  end

  def _find_all_color_and_spot_matches(evaluation, guesses)
    @temporary_target.each_with_index do |target_entry, index|
      evaluation[:color_and_spot] += 1 if guesses[index] == target_entry
    end
  end

  def _find_all_color_matches(evaluation, guesses)
    guesses.each do |guess|
      if @temporary_target.include?(guess)
        evaluation[:color] += 1
        _remove_one_object_from_array(@temporary_target, guess)
      end
    end
  end

  def _remove_one_object_from_array(array, object)
    array.delete_at(array.index(object))
  end

  def _remove_duplicate_color_matches(evaluation)
    evaluation[:color] = evaluation[:color] - evaluation[:color_and_spot]
  end
end
