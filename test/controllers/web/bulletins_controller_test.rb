# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  def setup
    sign_in users(:one)
    @bulletin = bulletins(:draft)
    @bulletin_attr = {
      title: @bulletin.title,
      description: @bulletin.description,
      user_id: @bulletin.user_id,
      category_id: @bulletin.category_id,
      image: fixture_file_upload('bulletin_0.jpg', 'image/jpeg')
    }
    @bulletin_to_update = bulletins(:under_moderation)
    @bulletin_attr_to_update = {
      title: @bulletin.title,
      description: @bulletin.description,
      user_id: @bulletin.user_id,
      category_id: @bulletin.category_id,
      image: fixture_file_upload('bulletin_1.jpg', 'image/jpeg')
    }
  end

  test 'should get index' do
    get bulletins_path
    assert_response :success
  end

  test 'should get show' do
    get bulletin_path(@bulletin)
    assert_response :success
  end

  test 'should get new' do
    get new_bulletin_url
    assert_response :success
  end

  test 'should create' do
    post bulletins_url, params: { bulletin: @bulletin_attr }
    assert_response :redirect
  end

  test 'should edit' do
    get edit_bulletin_url @bulletin
    assert_response :success
  end

  test 'should update' do
    patch bulletin_url(@bulletin_to_update), params: { bulletin: @bulletin_attr_to_update }
    assert_response :redirect
  end

  test 'should send to moderation bulletin' do
    sign_in @bulletin.user
    patch to_moderation_bulletin_path(@bulletin)
    assert { @bulletin.reload.under_moderation? }
    assert_redirected_to profile_path
  end

  test 'should archive bulletin' do
    sign_in @bulletin_to_update.user
    patch archive_bulletin_url(@bulletin_to_update)
    assert { @bulletin_to_update.reload.archived? }
    assert_redirected_to profile_path
  end
end
