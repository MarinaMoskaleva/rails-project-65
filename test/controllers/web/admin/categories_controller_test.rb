# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user_admin = users(:admin)
    @category = categories(:one)
  end

  test 'admin should get categories' do
    sign_in @user_admin
    get admin_categories_path
    assert_response :success
  end

  test 'admin should get new' do
    sign_in @user_admin
    get new_admin_category_path
    assert_response :success
  end

  test 'admin should create' do
    sign_in @user_admin
    name = Faker::Lorem.sentence
    post admin_categories_path, params: { category: { name: } }
    assert_redirected_to admin_categories_path
    assert { name == Category.last.name }
  end

  test 'admin should get edit' do
    sign_in @user_admin
    get edit_admin_category_path(@category)
    assert_response :success
  end

  test 'admin should update' do
    sign_in @user_admin
    name = Faker::Lorem.sentence
    patch admin_category_path(@category), params: { category: { name: } }
    assert_redirected_to admin_categories_path
    assert { name == @category.reload.name }
  end

  test 'admin should destroy' do
    sign_in @user_admin
    delete admin_category_path(@category)
    assert_redirected_to admin_categories_path
  end
end
