require "rspec"
require_relative "../lib/computer"
require_relative "../lib/guess_evaluator"

RSpec.describe Computer do # rubocop:disable Metrics/BlockLength
  before do
    @guess_evaluator_double = instance_double("GuessEvaluator")
    allow(@guess_evaluator_double).to receive(:evaluate_guess).and_return({ color_and_spot: 4 })
    @computer = Computer.new({ guess_evaluator: @guess_evaluator_double })
  end

  describe "#input" do # rubocop:disable Metrics/BlockLength
    it "responds to the input method" do
      expect(@computer).to respond_to(:input)
    end

    context "during a normal game" do # rubocop:disable Metrics/BlockLength
      xit "generates a new guess every time input is called" do
        allow(@guess_evaluator_double).to receive(:evaluate_guess).and_return({ color_and_spot: 1 })
        expect(@computer.input).to_not eql(@computer.input)
      end

      xit "returns [:yellow, :yellow, :yellow, :yellow] after getting evaluations 0, 0, 0, 4" do
        allow(@guess_evaluator_double).to receive(:evaluate_guess).and_return({ color_and_spot: 0 },
                                                                              { color_and_spot: 0 },
                                                                              { color_and_spot: 0 },
                                                                              { color_and_spot: 4 })
        4.times { @computer.input }
        expect(@computer.input).to eql(%i[yellow yellow yellow yellow])
      end

      xit "returns [:blue, :red, :red, :red] after getting evaluations 3, 3, 4]" do
        allow(@guess_evaluator_double).to receive(:evaluate_guess).and_return({ color_and_spot: 3 },
                                                                              { color_and_spot: 3 },
                                                                              { color_and_spot: 4 })
        3.times { @computer.input }
        expect(@computer.input).to eql(%i[blue red red red])
      end

      xit "returns [:red, :green, :red, :red] after getting evaluations 3, 2, 4]" do
        allow(@guess_evaluator_double).to receive(:evaluate_guess).and_return({ color_and_spot: 3 },
                                                                              { color_and_spot: 2 },
                                                                              { color_and_spot: 4 })
        3.times { @computer.input }
        expect(@computer.input).to eql(%i[red green red red])
      end

      xit "returns [:yellow, :green, :red, :red] after getting evaluations 2, 2, 2, 4]" do
        allow(@guess_evaluator_double).to receive(:evaluate_guess).and_return({ color_and_spot: 2 },
                                                                              { color_and_spot: 2 },
                                                                              { color_and_spot: 2 },
                                                                              { color_and_spot: 4 })
        4.times { @computer.input }
        expect(@computer.input).to eql(%i[yellow green red red])
      end

      xit "returns [:red, :red, :red, :green] after getting evaluations 3, 2, 2, 2, 4]" do
        allow(@guess_evaluator_double).to receive(:evaluate_guess).and_return({ color_and_spot: 3 },
                                                                              { color_and_spot: 3 },
                                                                              { color_and_spot: 3 },
                                                                              { color_and_spot: 3 },
                                                                              { color_and_spot: 4 })
        5.times { @computer.input }
        expect(@computer.input).to eql(%i[red red red green])
      end

      xit "returns [:yellow, :red, :red, :red] after getting evaluations 3, 3, 3, 4]" do
        allow(@guess_evaluator_double).to receive(:evaluate_guess).and_return({ color_and_spot: 3 },
                                                                              { color_and_spot: 3 },
                                                                              { color_and_spot: 3 },
                                                                              { color_and_spot: 4 })
        4.times { @computer.input }
        expect(@computer.input).to eql(%i[yellow red red red])
      end

      xit "returns [:red :red :red :red] as its first guess" do
        expect(@computer.input).to eql(%i[red red red red])
      end
    end
  end
end
