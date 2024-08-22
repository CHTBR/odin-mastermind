require "rspec"
require_relative "../lib/board"

RSpec.describe Board do
  subject { Board.new }

  describe "#target" do
    xit "sets the target sequence to the given input" do
      subject.target = %i[r g b y]
      expect(subject.target).to eql(%i[r g b y])
    end
  end

  describe "#set_column" do
    xit "sets the 1st column to the given sequence" do
      subject.set_column({ number: 1, sequence: %i[b g y y] })
      expect(subject.guesses[0]).to eql(%i[b g y y])
    end

    xit "sets the 12th column to the given sequence" do
      subject.set_column({ number: 12, sequence: %i[g r g y] })
      expect(subject.guesses[11]).to eql(%i[g r g y])
    end
  end

  describe "#to_s" do
    xit "returns an ASCII art board when turned into string" do
      expect(subject.to_s).to eql(
        "
        _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
       |     | :: :: :: :: :: :: :: :: :: :: :: ::   |
       |  ?  |  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^   |
       |  ?  |  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^   |
       |  ?  |  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^   |
       |  ?  |  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^  ^   |
       |_ _ _|_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _|
        \\ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ /

"
      )
    end
  end
end
