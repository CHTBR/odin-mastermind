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
    xit "responds to the input method" do
      expect(@computer).to respond_to(:input)
    end

    context "during a normal game" do
      xit "generates a new guess every time input is called" do
        expect(@computer.input).to_not eql(@computer.input)
      end

      xit "can guess a random target after at most 24 guesses" do
        23.times { @computer.input }
        expect(@computer.input).to eql(@guess_evaluator_double.target)
      end
    end
  end
end
