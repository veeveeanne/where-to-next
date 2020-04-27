require 'rails_helper'

feature 'user registers', %Q{
  As a visitor
  I want to register
  So that I can create an account
} do

  # Acceptance Criteria:
  # * I must specify a valid email address,
  #   first name, last name, password, and password confirmation
  # * If I don't specify the required information, I am presented with
  #   an error message

  scenario 'provide valid registration information' do
    visit new_user_registration_path

    fill_in 'Email', with: 'john@example.com'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Location', with: 'City'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to have_content('My Account')
    expect(page).to have_content('Sign Out')
  end

  scenario 'provide invalid registration information' do
    visit new_user_registration_path

    click_button 'Sign up'

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content('My Account')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'provide invalid password confirmation' do
    visit new_user_registration_path

    fill_in 'Email', with: 'john@example.com'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Location', with: 'City'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'PASSWORD'
    click_button 'Sign up'

    expect(page).to have_content("Password confirmation doesn't match Password")
    expect(find_field('Email').value).to eq('john@example.com')
    expect(find_field('First name').value).to eq('John')
    expect(find_field('Last name').value).to eq('Doe')
    expect(find_field('Location').value).to eq('City')
    expect(page).to_not have_content('My Account')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'provide an invalid email' do
    visit new_user_registration_path

    fill_in 'Email', with: 'john'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Location', with: 'City'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Sign up'

    expect(page).to have_content('Email is invalid')
    expect(find_field('Email').value).to eq('john')
    expect(find_field('First name').value).to eq('John')
    expect(find_field('Last name').value).to eq('Doe')
    expect(find_field('Location').value).to eq('City')
    expect(page).to_not have_content('Sign Out')
  end
end
