class Player
  def input(args)
    message = args.fetch(:message, "Choose one of the options:")
    options = args.fetch(:options, %w[yes no])
    puts message
    options.each { |option| puts option }
    gets
  end
end
