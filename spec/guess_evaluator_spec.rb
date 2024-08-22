require "rspec"
require_relative "../lib/guess_evaluator"

RSpec.describe GuessEvaluator do
  describe "#target=" do
    context "when given a target sequence" do
      xit "saves it into a target variable" do
        subject.target = %i[red red red blue]
        expect(subject.target).to eql(%i[red red red blue])
      end
    end
  end

  describe "#evaluate_guess" do
  end
end
