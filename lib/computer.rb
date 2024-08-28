class Computer
  def initialize(args)
    @raw_guess = [0, 0, 0, 0]
  end

  def _convert_raw_guess
    options = %i[red green blue yellow]
    Array.new(4).map.with_index { |_element, index| options[@raw_guess[index]] }
  end
end
