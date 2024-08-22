require "rspec"
require_relative "../lib/game_starter"
require_relative "../lib/player"
require_relative "startable_spec"

RSpec.describe GameStarter do
  before(:example) do
    input_manager_double = instance_double("Player", :input)
    startable_double1 = double("Startable Double 1")
    allow(startable_double1).to receive(:start)
    startable_double2 = double("Startable Double 2")
    allow(startable_double2).to receive(:start)
    game_starter = GameStarter.new({ input_manager: input_manager_double,
                                     mode_list: [startable_double1, startable_double2] })
  end
end
