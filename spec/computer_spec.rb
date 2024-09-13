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
      it "generates a new guess every time input is called" do
        allow(@guess_evaluator_double).to receive(:evaluate_guess).and_return({ color_and_spot: 0 })
        expect(@computer.input).to_not eql(@computer.input)
      end

      context "by implementing incrementing all columns by 1 when evaluation is zero from the beginning" do
        it "returns [:yellow, :yellow, :yellow, :yellow] after getting evaluations 0, 0, 0, 4" do
          allow(@guess_evaluator_double).to receive(:evaluate_guess).and_return({ color_and_spot: 0 },
                                                                                { color_and_spot: 0 },
                                                                                { color_and_spot: 0 },
                                                                                { color_and_spot: 4 })
          4.times { @computer.input }
          expect(@computer.input).to eql(%i[yellow yellow yellow yellow])
        end
      end

      context "by implementing incrementing a column until the evaluation is raised" do
        it "returns [:blue, :red, :red, :red] after getting evaluations 3, 3, 4]" do
          allow(@guess_evaluator_double).to receive(:evaluate_guess).and_return({ color_and_spot: 3 },
                                                                                { color_and_spot: 3 },
                                                                                { color_and_spot: 4 })
          3.times { @computer.input }
          expect(@computer.input).to eql(%i[blue red red red])
        end
      end

      context "by implementing switching to the next column when current is correct and evaluating it right after" do
        it "returns [:red, :green, :red, :red] after getting evaluations 3, 2, 4]" do
          allow(@guess_evaluator_double).to receive(:evaluate_guess).and_return({ color_and_spot: 3 },
                                                                                { color_and_spot: 2 },
                                                                                { color_and_spot: 4 })
          3.times { @computer.input }
          expect(@computer.input).to eql(%i[red green red red])
        end
      end

      context "by implementing skipping the last option and switching to next column and evaluating it right after" do
        it "returns [:yellow, :green, :red, :red] after getting evaluations 2, 2, 2, 4]" do
          allow(@guess_evaluator_double).to receive(:evaluate_guess).and_return({ color_and_spot: 2 },
                                                                                { color_and_spot: 2 },
                                                                                { color_and_spot: 2 },
                                                                                { color_and_spot: 4 })
          4.times { @computer.input }
          expect(@computer.input).to eql(%i[yellow green red red])
        end
      end

      context "by correctly chaining switching to the next column when current is correct" do
        it "returns [:red, :red, :red, :green] after getting evaluations 3, 2, 2, 2, 4]" do
          allow(@guess_evaluator_double).to receive(:evaluate_guess).and_return({ color_and_spot: 3 },
                                                                                { color_and_spot: 2 },
                                                                                { color_and_spot: 2 },
                                                                                { color_and_spot: 2 },
                                                                                { color_and_spot: 4 })
          5.times { @computer.input }
          expect(@computer.input).to eql(%i[red red red green])
        end
      end

      context "by implementing correcting when the last guess was incorrect and switching to the next column and evaluating it right after" do
        it "returns [:yellow, :red, :red, :red] after getting evaluations 3, 3, 3, 3, 4]" do
          allow(@guess_evaluator_double).to receive(:evaluate_guess).and_return({ color_and_spot: 3 },
                                                                                { color_and_spot: 3 },
                                                                                { color_and_spot: 3 },
                                                                                { color_and_spot: 3 },
                                                                                { color_and_spot: 4 })
          4.times { @computer.input }
          expect(@computer.input).to eql(%i[yellow red red red])
        end
      end

      it "returns [:red :red :red :red] as its first guess" do
        expect(@computer.input).to eql(%i[red red red red])
      end

      context "possibly unneeded test" do
        it "returns [:red, :green, :blue, :yellow] after getting evaluations 1, 0, 2, 2, 3, 3, 3, 4]" do
          allow(@guess_evaluator_double).to receive(:evaluate_guess).and_return({ color_and_spot: 1 },
                                                                                { color_and_spot: 0 },
                                                                                { color_and_spot: 2 },
                                                                                { color_and_spot: 2 },
                                                                                { color_and_spot: 3 },
                                                                                { color_and_spot: 3 },
                                                                                { color_and_spot: 3 },
                                                                                { color_and_spot: 4 })
          8.times { @computer.input }
          expect(@computer.input).to eql(%i[red green blue yellow])
        end

        it "returns [:blue, :green, :green, :green] after getting evaluations 0, 3, 4]" do
          allow(@guess_evaluator_double).to receive(:evaluate_guess).and_return({ color_and_spot: 0 },
                                                                                { color_and_spot: 3 },
                                                                                { color_and_spot: 4 })
          3.times { @computer.input }
          expect(@computer.input).to eql(%i[blue green green green])
        end

        it "returns [:yellow, :green, :green, :blue] after getting evaluations 0, 2, 2, 2, 2, 4]" do
          allow(@guess_evaluator_double).to receive(:evaluate_guess).and_return({ color_and_spot: 0 },
                                                                                { color_and_spot: 2 },
                                                                                { color_and_spot: 2 },
                                                                                { color_and_spot: 2 },
                                                                                { color_and_spot: 2 },
                                                                                { color_and_spot: 4 })
          5.times { @computer.input }
          expect(@computer.input).to eql(%i[yellow green green blue])
        end
      end
    end
  end
end
