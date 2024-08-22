require "rspec"
require_relative "../lib/board"

RSpec.describe Board do
  descibe "#target" do
    it "sets the target sequence to the given input" do
      subject.target = %i[r g b y]
      expect(subject.target).to eql(%i[r g b y])
    end
  end

  describe "#set_column" do
  end

  describe "#to_s" do
  end
end
