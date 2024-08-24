class ComputerMode
  def initialize(args)
    @guess_evaluator = args[:guess_evaluator]
  end

  def start
    @guess_evaluator.target = (Array.new(4).map { |_element| %i[red green red yellow].shuffle.shuffle.sample })
  end
end
