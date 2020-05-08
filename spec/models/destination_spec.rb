require 'rails_helper'

RSpec.describe Destination, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
  end

  describe 'associations' do
    it { should belong_to(:airport).optional }
    it { should have_many(:listings) }
    it { should have_many(:users).through(:listings) }
  end
end
