require 'rails_helper'

RSpec.describe Airport, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
    it { should validate_presence_of(:iata_code) }
  end

  describe 'associates' do
    it { should have_many(:destinations) }
  end
end
