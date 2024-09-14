require_relative "lib/game_starter"
require_relative "lib/player"
require_relative "lib/computer_mode"
require_relative "lib/player_mode"
require_relative "lib/guess_evaluator"
require_relative "lib/computer"
require_relative "lib/board"

input_manager = Player.new
guess_evaluator = GuessEvaluator.new
board = Board.new

player_mode = PlayerMode.new({ input_manager: input_manager, board: board, guess_evaluator: guess_evaluator })

computer = Computer.new({ guess_evaluator: guess_evaluator })
computer_mode = ComputerMode.new({ guess_evaluator: guess_evaluator, board: board, computer: computer,
                                   input_manager: input_manager })
game_starter = GameStarter.new({ input_manager: input_manager, mode_list: [player_mode, computer_mode] })

game_starter.start_game
