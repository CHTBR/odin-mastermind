require "rspec"
require_relative "../lib/game_starter"
require_relative "startable_spec"
require_relative "input_manager_spec"

class ModeDouble
  def start
  end
end

class InputManagerDouble
  def input
  end
end

RSpec.describe ModeDouble do
  it_behaves_like "a startable" do
    let(:subject) { ModeDouble.new }
  end
end

RSpec.describe InputManagerDouble do
  it_behaves_like "an input manager" do
    let(:subject) { InputManagerDouble.new }
  end

  describe "#input" do
    it "returns string 'input'" do
      expect(subject.input).to eql("input")
    end
  end
end

RSpec.describe GameStarter do
  subject { GameStarter.new({ input_manager: InputManagerDouble.new, mode_list: [ModeDouble.new, ModeDouble.new] }) }
end
