require 'rails_helper'

RSpec.describe Destination, type: :model do
  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:state) }
  end

  context "associations" do
    it { should have_many(:listings) }
    it { should have_many(:users).through(:listings) }
  end
end
