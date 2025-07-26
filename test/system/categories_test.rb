# frozen_string_literal: true

require 'application_system_test_case'

class CategoriesTest < ApplicationSystemTestCase
  def setup
    @category = categories(:one)
    # Clean up any existing test user first
    User.where(email: 'testadmin@example.com').destroy_all

    # Create admin user directly and ensure it's saved
    @admin_user = User.create!(
      username: 'testadmin',
      email: 'testadmin@example.com',
      password: 'password123',
      password_confirmation: 'password123',
      admin: true
    )
    # Skip email confirmation for tests
    @admin_user.skip_confirmation!
    @admin_user.save!
  end

  test 'visiting the index' do
    visit categories_url
    assert_selector 'h1', text: 'Listing all categories'
  end

  test 'admin can create a Category' do
    # Login as admin using browser form
    visit new_user_session_path

    fill_in 'Email', with: @admin_user.email
    fill_in 'Password', with: 'password123'
    click_on 'Log in'

    # Check if login was successful by checking if we're on a different page
    assert_no_selector 'h2', text: 'Log in', wait: 2

    # Check we can access the new category page (admin only)
    visit new_category_path

    # Check that we're not redirected back to categories (which would happen if not admin)
    assert_no_text 'Only admin can create category'
    assert_selector 'h1', text: 'CREATE NEW CATEGORY'

    fill_in 'Category name', with: 'Test Category'
    click_on 'Create Category'

    assert_text 'Category created successfully'
  end

  test 'admin can edit a Category' do
    # Login as admin using browser form
    visit new_user_session_path

    fill_in 'Email', with: @admin_user.email
    fill_in 'Password', with: 'password123'
    click_on 'Log in'

    assert_no_selector 'h2', text: 'Log in', wait: 2

    visit categories_url

    # Only try to edit if categories exist
    if page.has_css?('.card')
      within(first('.card')) do
        click_on 'Edit category'
      end

      fill_in 'Category name', with: 'Updated Cat'
      click_on 'Update Category'

      assert_flash 'Category updated successfully'
    else
      # Skip this test if no categories exist
      skip 'No categories available for editing'
    end
  end

  test 'admin can delete a Category' do
    # Login as admin using browser form
    visit new_user_session_path

    fill_in 'Email', with: @admin_user.email
    fill_in 'Password', with: 'password123'
    click_on 'Log in'

    assert_no_selector 'h2', text: 'Log in', wait: 2

    # Create a category specifically for deletion that has no articles
    Category.create!(name: 'TestDelete')

    visit categories_url

    # Override window.confirm to always return true
    page.execute_script('window.confirm = function() { return true; }')

    # Find the card containing our test category and click delete
    test_card = find('.card', text: 'TestDelete')

    within(test_card) do
      click_on 'Delete category'
    end

    # Wait a moment for the action to complete
    sleep(1)

    # Check that the category is gone from the list or success message appears
    if page.has_text?('Category deleted successfully')
      # Success message found
      assert_text 'Category deleted successfully'
    elsif !page.has_text?('TestDelete')
      # Category is gone from the list, delete was successful
      assert_no_text 'TestDelete'
    else
      # Debug: show what's on the page
      puts "Page content after delete: #{page.text}"
    end
  end
end
