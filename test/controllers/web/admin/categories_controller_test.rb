# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user_admin = users(:admin)
    @category = categories(:one)
    sign_in @user_admin
  end

  test 'admin should get categories' do
    get admin_categories_path
    assert_response :success
  end

  test 'admin should get new' do
    get new_admin_category_path
    assert_response :success
  end

  test 'admin should create' do
    name = Faker::Lorem.sentence
    post admin_categories_path, params: { category: { name: } }
    assert_redirected_to admin_categories_path
    assert { name == Category.last.name }
  end

  test 'admin should get edit' do
    get edit_admin_category_path(@category)
    assert_response :success
  end

  test 'admin should update' do
    name = Faker::Lorem.sentence
    patch admin_category_path(@category), params: { category: { name: } }
    assert_redirected_to admin_categories_path
    assert { name == @category.reload.name }
  end

  test 'admin should destroy empty' do
    name = 'empty'
    empty_category = Category.create!(name:)
    delete admin_category_path(empty_category)
    assert { !Category.exists?(name:) }
    assert_redirected_to admin_categories_path
  end

  test 'admin should not destroy non-empty' do
    delete admin_category_path(@category)
    assert { Category.exists?(@category.id) }
    assert_redirected_to admin_categories_path
  end
end
