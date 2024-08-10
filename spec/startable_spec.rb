require "rspec"

RSpec.shared_examples "a startable" do
  it "responds to the #start method" do
    expect(subject).to respond_to(:start)
  end
end
