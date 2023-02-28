require "rails_helper"

RSpec.feature "homepage", :type => :feature do
  scenario "check homepage contents" do
    visit root_path

    expect(page).to have_text("Mystery lunch to be generated for month")

    create_list(:department, 7)
    create_list(:employee, 6)
    LunchPartner.create_mystery_lunches(Date.today)

    visit root_path

    expect(page).to have_text("Mystery Partners for February")

    click_link("See all previous partners", :match => :first)
    expect(page).to have_text("Previous Lunch partners")


    click_link('Manage')
    expect(page).to have_text("Password :")

    fill_in 'Password', with: 'admin'
    click_button('Go')
    expect(page).to have_text("Create")
    expect(page).to have_text("Signout")
  end

  scenario "Edit user" do
    create_list(:department, 7)
    create_list(:employee, 6)
    LunchPartner.create_mystery_lunches(Date.today)

    visit root_path

    click_link('Manage')
    fill_in 'Password', with: 'admin'
    click_button('Go')
    expect(page).to have_text("Create")
    expect(page).to have_text("Signout")
    expect(page).to have_text("Edit")
    click_link("Edit", :match => :first)

    fill_in 'Name', with: 'Rambo'
    click_button('SUBMIT')

    expect(page).to have_text("Rambo")
  end
end