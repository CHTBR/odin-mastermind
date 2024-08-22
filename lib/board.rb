class Board
  attr_accessor :target
  attr_reader :guesses

  def initialize
    @guesses = Array.new(12) { Array.new(4) }
  end

  def set_column(args)
    @guesses[args[:number] - 1] = args[:sequence]
  end

  def to_s
    "
        _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
       |     | :: :: :: :: :: :: :: :: :: :: :: ::   |
       |  ?  |  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^   |
       |  ?  |  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^   |
       |  ?  |  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^   |
       |  ?  |  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^   |
       |_ _ _|_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _|
        \\ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ /

"
  end
end
