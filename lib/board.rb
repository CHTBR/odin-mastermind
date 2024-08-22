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
    string = ""
    append_top(string)
    loop_rows(string)
    append_bottom(string)
    string
  end

  def append_top(string)
    string << "
        _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
       |     | :: :: :: :: :: :: :: :: :: :: :: ::   |\n"
  end

  def loop_rows(string)
    4.times do |row|
      append_target(string)
      loop_columns(string, row)
      string << "   |\n"
    end
  end

  def append_target(string)
    string << "       |  "
    string << (target.nil? ? "?" : "^".colorize(target[row]))
    string << "  |"
  end

  def loop_columns(string, row)
    12.times do |column|
      append_guess_notch(string, column, row)
    end
  end

  def append_guess_notch(string, column, row)
    string << "  "
    string << "^".colorize(@guesses[column][row])
  end

  def append_bottom(string)
    string << "       |_ _ _|_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _|
        \\ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ /

"
  end
end

puts Board.new
