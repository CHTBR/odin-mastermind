require "rspec"

RSpec.shared_examples "behaves like a startable" do
  it "responds to the #start method" do
    expect(subject).to respond_to(:start)
  end
end
