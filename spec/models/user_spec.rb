require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid email, first name, last name, and password" do
    user = User.new(
      email: "user@email.com",
      first_name: "John",
      last_name: "Doe",
      password: "123456"
    )

    expect(user).to be_valid
  end

  it "is not valid without an email" do
    user = User.new(
      first_name: "John",
      last_name: "Doe",
      password: "123456"
    )

    expect(user).to_not be_valid
    expect(user.errors.full_messages.to_sentence).to eq "Email can't be blank"
  end

  it "is not valid with an invalid email" do
    user = User.new(
      email: "user",
      first_name: "John",
      last_name: "Doe",
      password: "123456"
    )

    expect(user).to_not be_valid
    expect(user.errors.full_messages.to_sentence).to eq "Email is invalid"
  end

  it "is not valid with an email that is already registered" do
    user1 = User.create(
      email: "user@email.com",
      first_name: "John",
      last_name: "Doe",
      password: "123456"
    )
    user2 = User.new(
      email: "user@email.com",
      first_name: "Jane",
      last_name: "Smith",
      password: "123456"
    )

    expect(user2).to_not be_valid
    expect(user2.errors.full_messages.to_sentence).to eq "Email has already been taken"
  end

  it "is not valid without a first name" do
    user = User.new(
      email: "user@email.com",
      last_name: "Doe",
      password: "123456"
    )

    expect(user).to_not be_valid
    expect(user.errors.full_messages.to_sentence).to eq "First name can't be blank"
  end

  it "is not valid without a last name" do
    user = User.new(
      email: "user@email.com",
      first_name: "John",
      password: "123456"
    )

    expect(user).to_not be_valid
    expect(user.errors.full_messages.to_sentence).to eq "Last name can't be blank"
  end

  it "is not valid without a password" do
    user = User.new(
      email: "user@email.com",
      first_name: "John",
      last_name: "Doe"
    )

    expect(user).to_not be_valid
    expect(user.errors.full_messages.to_sentence).to include "Password can't be blank"
  end

  it "is not valid with an invalid password" do
    user1 = User.new(
      email: "user@email.com",
      first_name: "John",
      last_name: "Doe",
      password: "1234"
    )

    expect(user1).to_not be_valid
    expect(user1.errors.full_messages.to_sentence).to eq "Password is too short (minimum is 6 characters)"

    user2 = User.new(
      email: "user@email.com",
      first_name: "John",
      last_name: "Doe",
      password: "abcdefghijklmnopqrstuvwxyz"
    )

    expect(user2).to_not be_valid
    expect(user2.errors.full_messages.to_sentence).to eq "Password is too long (maximum is 20 characters)"
  end
end
