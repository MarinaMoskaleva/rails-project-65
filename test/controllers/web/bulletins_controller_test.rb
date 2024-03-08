# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  def setup
    sign_in users(:one)
    @bulletin = bulletins(:draft)
    @bulletin_to_update = bulletins(:under_moderation)
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
    bulletin_attr = {
      title: Faker::Lorem.unique.sentence.slice(...50),
      description: Faker::Lorem.unique.paragraph.slice(...1000),
      user_id: @bulletin.user_id,
      category_id: @bulletin.category_id,
      image: fixture_file_upload('bulletin_0.jpg', 'image/jpeg')
    }
    post bulletins_url, params: { bulletin: bulletin_attr }
    last_created_bulletin = Bulletin.last
    assert_redirected_to root_path
    assert_equal bulletin_attr[:title], last_created_bulletin.title
    assert_equal bulletin_attr[:description], last_created_bulletin.description
    assert_equal bulletin_attr[:user_id], last_created_bulletin.user_id
    assert_equal bulletin_attr[:category_id], last_created_bulletin.category_id
    assert_not_nil last_created_bulletin.image
  end

  test 'should edit' do
    get edit_bulletin_url @bulletin
    assert_response :success
  end

  test 'should update' do
    bulletin_attr_to_update = {
      title: Faker::Lorem.unique.sentence.slice(...50),
      description: Faker::Lorem.unique.paragraph.slice(...1000),
      user_id: @bulletin_to_update.user_id,
      category_id: @bulletin_to_update.category_id,
      image: fixture_file_upload('bulletin_1.jpg', 'image/jpeg')
    }
    patch bulletin_url(@bulletin_to_update), params: { bulletin: bulletin_attr_to_update }
    assert_redirected_to root_path

    @bulletin_to_update.reload
    assert_equal bulletin_attr_to_update[:title], @bulletin_to_update.title
    assert_equal bulletin_attr_to_update[:description], @bulletin_to_update.description
  end

  test 'should send to moderation bulletin' do
    patch to_moderation_bulletin_path(@bulletin)
    assert { @bulletin.reload.under_moderation? }
    assert_redirected_to profile_path
  end

  test 'should archive bulletin' do
    patch archive_bulletin_url(@bulletin_to_update)
    assert { @bulletin_to_update.reload.archived? }
    assert_redirected_to profile_path
  end
end
