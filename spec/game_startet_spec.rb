require "rspec"
require_relative "../lib/game_starter"

RSpec.describe GameStarter do
  subject { GameStarter.new({ input_manager: InputManagerDouble.new, mode_list: [ModeDouble.new, ModeDouble.new] }) }
end
