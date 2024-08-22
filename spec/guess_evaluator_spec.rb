require "rspec"
require_relative "../lib/guess_evaluator"

RSpec.describe GuessEvaluator do
  describe "#target=" do
    context "when given a target sequence" do
      it "saves it into a target variable" do
        subject.target = %i[red red red blue]
        expect(subject.target).to eql(%i[red red red blue])
      end
    end
  end

  describe "#evaluate_guess" do
    context "after setting a target" do
      before do
        subject.target = %i[red green blue red]
      end

      it "compares an identical sequence against it" do
        expect(subject.evaluate_guess(%i[red green blue red])).to eql({ color_and_spot: 4, color: 0 })
      end

      it "compares a scrambled sequence with the same colors in different places against it" do
        expect(subject.evaluate_guess(%i[green red red blue])).to eql({ color_and_spot: 0, color: 4 })
      end

      it "compares a partially identical sequence with the same color" do
        expect(subject.evaluate_guess(%i[green blue red red])).to eql({ color_and_spot: 1, color: 3 })
      end

      it "compares a completely incorrect sequence against it" do
        expect(subject.evaluate_guess(%i[yellow yellow yellow yellow])).to eql({ color_and_spot: 0, color: 0 })
      end
    end
  end
end
