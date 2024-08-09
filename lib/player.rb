class Player
  def input(args)
    message = args.fetch(:message, "Choose one of the options:")
    puts message
    args.fetch(:options, %w[yes no]).each { |option| puts option }
  end
end
