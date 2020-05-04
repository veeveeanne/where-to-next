require 'rails_helper'

RSpec.describe Listing, type: :model do
  describe 'associations' do
    it { should belong_to(:destination) }
    it { should belong_to(:user) }
  end
end
