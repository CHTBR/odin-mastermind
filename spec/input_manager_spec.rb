require "rspec"

RSpec.shared_examples "an input manager" do
  it "responds to the #input method" do
    expect(subject).to respond_to(:input)
  end
end
