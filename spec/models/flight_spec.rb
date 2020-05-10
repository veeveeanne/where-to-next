require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'validations' do
    it { should validate_presence_of :departure_iata }
    it { should validate_presence_of :destination_iata }
    it { should validate_presence_of :departure_date }
    it { should validate_presence_of :return_date }
    it { should validate_presence_of :average_price }
    it { should validate_numericality_of :average_price}
  end
end
