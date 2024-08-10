require_relative "../lib/player"
require "rspec"

RSpec.describe Player do
  describe "#input" do
    context "when only testing message" do
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

    context "when only testing input options" do
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
