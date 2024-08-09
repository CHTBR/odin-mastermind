class Player
  def input(args)
    message = args.fetch(:message, "Choose one of the options:")
    puts message
  end
end
