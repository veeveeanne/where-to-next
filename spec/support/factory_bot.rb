require 'factory_bot'

FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    first_name { 'John' }
    last_name { 'Doe' }
    location { 'City' }
    password { 'password' }
    password_confirmation { 'password' }
  end

end
