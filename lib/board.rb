require "colorize"

class Board
  attr_accessor :target
  attr_reader :guesses

  def initialize
    @guesses = Array.new(12) { Array.new(4, :default) }
  end

  def set_column(args)
    @guesses[args[:number]] = args[:sequence]
  end

  def to_s
    string = ""
    _append_top(string)
    _loop_rows(string)
    _append_bottom(string)
    string
  end

  def _append_top(string)
    string << "
        _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
       |     | :: :: :: :: :: :: :: :: :: :: :: ::   |\n"
  end

  def _loop_rows(string)
    4.times do |row|
      _append_target(string, row)
      _loop_columns(string, row)
      string << "   |\n"
    end
  end

  def _append_target(string, row)
    string << "       |  "
    string << (target.nil? ? "?" : "^".colorize(target[row]))
    string << "  |"
  end

  def _loop_columns(string, row)
    12.times do |column|
      _append_guess_notch(string, column, row)
    end
  end

  def _append_guess_notch(string, column, row)
    string << "  "
    string << "^".colorize(@guesses[column][row])
  end

  def _append_bottom(string)
    string << "       |_ _ _|_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _|
        \\ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ /

"
  end
end
