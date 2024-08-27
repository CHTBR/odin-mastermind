require "rspec"
require_relative "../lib/computer"
require_relative "../lib/guess_evaluator"

RSpec.describe Computer do
  before do
    @guess_evaluator_double = instance_double("GuessEvaluator")
    allow(@guess_evaluator_double).to receive(:input).and_return(evaluate_guess: { color_and_spot: 4 })
    @computer = Computer.new({ guess_evaluator: @guess_evaluator_double })
  end

  describe "#input" do
    it "responds to the input method" do
      expect(@computer).to respond_to(:input)
    end

    context "during a normal game" do
      it "generates a new guess every time input is called" do
        allow(@guess_evaluator_double).to receive(:input).and_return(evaluate_guess: { color_and_spot: 1 })
        expect(@computer.input).to_not eql(@computer.input)
      end

      xit "returns [:yellow, :yellow, :yellow, :yellow] after getting evaluations 0, 0, 0, 4" do
        allow(@guess_evaluator_double).to receive(:input).and_return({ color_and_spot: 0 }, { color_and_spot: 0 },
                                                                     { color_and_spot: 0 }, { color_and_spot: 4 })
        4.times { @computer.input }
        expect(@computer.input).to eql(%i[yellow yellow yellow yellow])
      end

      xit "returns [:red :red :red :red] as its first guess" do
        expect(@computer.input).to eql(%i[red red red red])
      end
    end
  end
end
