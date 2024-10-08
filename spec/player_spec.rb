require "rspec"
require_relative "../lib/player"
require_relative "input_manager_spec"

RSpec.describe Player do
  it_behaves_like "an input manager" do
    let(:subject) { Player.new }
  end

  describe "#input" do
    context "when only testing input" do
      it "returns chosen option" do
        options = %w[left right up down]
        allow_any_instance_of(Object).to receive(:gets).and_return("up")
        expect(subject.input({ options: options })).to eql("up")
      end

      it "prompts you again in case of incorrect input" do
        options = %w[left right up down]
        allow_any_instance_of(Object).to receive(:gets).and_return("bogus input", "left")
        expect(subject.input({ options: options })).to eql("left")
      end
    end
    context "when using different types of options" do
      it "works with numerical options" do
        options = [1, 2, 3, 4]
        allow_any_instance_of(Object).to receive(:gets).and_return("4")
        expect(subject.input({ options: options })).to eql(4)
      end

      it "works with symbols" do
        options = %i[one two three four]
        allow_any_instance_of(Object).to receive(:gets).and_return("three")
        expect(subject.input({ options: options })).to eql(:three)
      end
    end
  end
end
