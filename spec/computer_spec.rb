require "rspec"
require_relative "../lib/computer"
require_relative "../lib/guess_evaluator"

RSpec.describe Computer do
  before do
    @guess_evaluator_double = instance_double("GuessEvaluator", target: Array.new(4).map do |_element|
                                                                          %i[red green red yellow].shuffle.shuffle.sample
                                                                        end)
    @computer = Computer.new({ guess_evaluator: @guess_evaluator_double })
  end

  describe "#input" do
  end
end
