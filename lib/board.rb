require "colorize"

class Board
  attr_accessor :target
  attr_reader :guesses

  def initialize
    @guesses = Array.new(12) { Array.new(4, :default) }
  end

  def set_column(args)
    @guesses[args[:number] - 1] = args[:sequence]
  end

  def to_s
    string = "
        _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
       |     | :: :: :: :: :: :: :: :: :: :: :: ::   |\n"
    4.times do |row|
      string << "       |  "
      string << (target.nil? ? "?" : "^".colorize(target[row]))
      string << "  |"
      12.times do |column|
        string << "  "
        string << "^".colorize(@guesses[column][row])
      end
      string << "   |\n"
    end
    string << "       |_ _ _|_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _|
        \\ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ /

"
    string
  end
end
