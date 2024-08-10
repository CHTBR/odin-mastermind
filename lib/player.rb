class Player
  def input(args)
    message = args.fetch(:message, "Choose one of the options:")
    options = args.fetch(:options, %w[yes no])
    _print_message(message)
    _print_each_option(options)
    _start_input_loop(options)
  end

  def _print_message(message)
    puts message
  end

  def _print_each_option(options)
    options.each { |option| puts "* #{option}" }
  end

  def _start_input_loop(options)
    loop do
      input = gets.chomp
      selected_option = options.select { |option| option.to_s == input }.first
      return selected_option if selected_option
    end
  end
end
