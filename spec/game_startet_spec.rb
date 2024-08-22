require "rspec"
require_relative "../lib/game_starter"
require_relative "../lib/player"
require_relative "startable_spec"

RSpec.describe GameStarter do
  before(:example) do
    @input_manager_double = instance_double("Player")
    @startable_double1 = double("Startable Double 1")
    allow(@startable_double1).to receive(:start)
    @startable_double2 = double("Startable Double 2")
    allow(@startable_double2).to receive(:start)
    @game_starter = GameStarter.new({ input_manager: @input_manager_double,
                                      mode_list: [@startable_double1, @startable_double2] })
  end

  describe "#start_game" do
    it "responds to #start_game" do
      expect(@game_starter).to respond_to(:start_game)
    end

    xit "calls the input method of input_manager with message and options arguments" do
      allow(@input_manager_double).to receive(:input).and_return(@startable_double1)
      expect(@input_manager_double).to receive(:input).with({ message: "Select game mode:",
                                                              options: [@startable_double1, @startable_double2] })
      @game_starter.start_game
    end

    xit "calls the start method of startable_double1 when given by input_manager" do
      allow(@input_manager).to receive(:input).and_return(@startable_double1)
      expect(@startable_double1).to receive(:start)
      @game_starter.start_game
    end

    xit "calls the start method of startable_double2 when given by input_manager" do
      allow(@input_manager).to receive(:input).and_return(@startable_double2)
      expect(@startable_double2).to receive(:start)
      @game_starter.start_game
    end
  end
end
