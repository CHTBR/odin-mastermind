require "rspec"
require_relative "../lib/computer_mode"
require_relative "startable_spec"

RSpec.describe ComputerMode do
  it_behaves_like "a startable" do
    subject { ComputerMode.new }
  end
end
