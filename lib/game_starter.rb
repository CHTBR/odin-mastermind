class GameStarter
  def initialize(args)
    @input_manager = args[:input_manager]
    @mode_list = args[:mode_list]
  end

  def start_game
    @input_manager.input({ message: "Select game mode:", options: @mode_list })
  end
end
