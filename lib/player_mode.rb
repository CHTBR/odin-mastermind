class PlayerMode
  def initialize(args)
    @guess_evaluator = args[:guess_evaluator]
  end

  def start
    @guess_evaluator.target = Array.new(4) { %i[red green blue yellow].shuffle.shuffle.sample } # Use multiple shuffles to increase randomness
  end

  def to_s
    "Player Mode"
  end
end
