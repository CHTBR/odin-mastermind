class GameStarter
  def initialize(args)
    @input_manager = args[:input_manager]
    @mode_list = args[:mode_list]
  end

  def start_game
    selected_game_mode = @input_manager.input({ message: "Select game mode:", options: @mode_list })
    selected_game_mode.start
  end
end
