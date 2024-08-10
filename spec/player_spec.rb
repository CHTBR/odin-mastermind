require_relative "../lib/player"
require "rspec"

RSpec.describe Player do
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
  end
end
