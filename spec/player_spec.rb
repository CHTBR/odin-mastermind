require_relative "../lib/player"
require "rspec"

RSpec.describe Player do
  describe "#input" do
    context "does it send a message to the player describing what it wants" do
      default_message = /Choose one of the options:/
      message = "Choose yes or no:"

      it "prints a default message" do
        expect { subject.input({}) }.to output(default_message).to_stdout
      end

      it "prints message given as argument" do
        expect { subject.input({ message: message }) }.to output(Regexp.new(message)).to_stdout
      end

      it "prints only message given as argument" do
        expect { subject.input({ message: message }) }.to_not output(default_message).to_stdout
      end
    end

    context "does it print out every given input option" do
      it "prints a default set of input options" do
        expect { subject.input({}) }.to output(/yes/).to_stdout
        expect { subject.input({}) }.to output(/no/).to_stdout
      end

      it "prints every given input option" do
        expect { subject.input({ options: %w[left right up down] }) }.to output(/left/).to_stdout
        expect { subject.input({ options: %w[left right up down] }) }.to output(/right/).to_stdout
        expect { subject.input({ options: %w[left right up down] }) }.to output(/up/).to_stdout
        expect { subject.input({ options: %w[left right up down] }) }.to output(/down/).to_stdout
      end
    end
  end
end
