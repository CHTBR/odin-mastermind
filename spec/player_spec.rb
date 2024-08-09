require_relative "../lib/player"
require "rspec"

RSpec.describe Player do
  describe "#input" do
    context "does it send a message to the player describing what it wants" do
      it "prints out a default message" do
        default_message = /Choose one of the options:/
        expect { subject.input }.to output(default_message).to_stdout
      end

      it "prints out only message given as argument" do
        message = "Choose yes or no:"
        expect { subject.input({ message: message }) }.to output(Regexp.new(message)).to_stdout
      end
    end
  end
end
