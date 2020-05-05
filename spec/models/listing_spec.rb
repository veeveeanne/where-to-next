require 'rails_helper'

RSpec.describe Listing, type: :model do
  describe 'associations' do
    subject { Listing.create(destination_id: 1, user_id: 1) }
    
    it { should belong_to(:destination) }
    it { should belong_to(:user) }
    it { should validate_uniqueness_of(:destination_id).scoped_to(:user_id).with_message("has already been added to your list") }
  end
end
