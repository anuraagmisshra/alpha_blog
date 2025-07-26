require 'rails_helper'

RSpec.describe 'Application Infrastructure', type: :system do
  it 'has working homepage' do
    visit root_path
    expect(page).to have_content('Alpha Blog')
    expect(page).to have_css('nav.navbar')
  end

  it 'has basic application structure' do
    visit root_path
    expect(page).to have_css('.navbar-brand')
    expect(page).to have_content('Alpha Blog')
  end
end
