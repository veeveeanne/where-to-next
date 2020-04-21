require 'rails_helper'

RSpec.describe Destination, type: :model do
  it "valid with valid name and state" do
    destination = Destination.new(
      name: "Boston",
      state: "Massachusetts"
    )

    expect(destination).to be_valid
  end

  it "is not valid without a name" do
    destination = Destination.new(
      state: "Massachusetts"
    )

    expect(destination).to_not be_valid
  end

  it "is not valid without a state" do
    destination = Destination.new(
      name: "Boston"
    )

    expect(destination).to_not be_valid
  end
end
