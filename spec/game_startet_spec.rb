require "rspec"
require_relative "../lib/game_starter"
require_relative "../lib/player"
require_relative "startable_spec"

class ModeDouble
  def start
  end
end

RSpec.describe ModeDouble do
  it_behaves_like "a startable" do
    let(:subject) { ModeDouble.new }
  end
end

RSpec.describe GameStarter do
  let(:input_manager) { instance_double("Player") }
  subject { GameStarter.new({ input_manager: input_manager, mode_list: [ModeDouble.new, ModeDouble.new] }) }
end
