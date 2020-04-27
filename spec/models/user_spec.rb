require 'rails_helper'

RSpec.describe User, type: :model do
  context 'associations' do
    it { should have_many(:listings) }
    it { should have_many(:destinations).through(:listings) }
  end

  context 'validations' do
    subject { FactoryBot.create(:user) }

    it { should validate_presence_of(:email) }

    it do
      should validate_uniqueness_of(:email).
      ignoring_case_sensitivity.
      on(:create)
    end

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password).on(:create) }

    it do
      should validate_length_of(:password).
        is_at_least(6).
        is_at_most(20).
        on(:create)
    end

    it { should validate_presence_of(:location) }
  end
end
