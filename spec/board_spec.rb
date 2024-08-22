require "rspec"
require_relative "../lib/board"

RSpec.configure do |c|
  c.filter_run_excluding broken: true
end

RSpec.describe Board do
  subject { Board.new }

  describe "#target" do
    it "sets the target sequence to the given input" do
      subject.target = %i[red green blue yellow]
      expect(subject.target).to eql(%i[red green blue yellow])
    end
  end

  describe "#set_column" do
    it "sets the 1st column to the given sequence" do
      subject.set_column({ number: 1, sequence: %i[blue green yellow yellow] })
      expect(subject.guesses[0]).to eql(%i[blue green yellow yellow])
    end

    it "sets the 12th column to the given sequence" do
      subject.set_column({ number: 12, sequence: %i[green red green yellow] })
      expect(subject.guesses[11]).to eql(%i[green red green yellow])
    end
  end

  describe "#to_s" do
    it "returns an ASCII art board when turned into string", :broken do
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
