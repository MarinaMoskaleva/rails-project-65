# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user_admin = users(:admin)
    @bulletin = bulletins(:under_moderation)
  end

  test 'admin should get all bulletins' do
    sign_in @user_admin
    get admin_bulletins_path
    assert_response :success
  end

  test 'admin should get bulletins on moderation' do
    sign_in @user_admin
    get on_moderation_admin_bulletins_path
    assert_response :success
  end

  # test 'should publish bulletin' do
  #   sign_in @user_admin
  #   patch publish_admin_bulletin_path(@bulletin)
  #   assert { @bulletin.reload.published? }
  #   assert_response :redirect
  # end

  # test 'should archive bulletin' do
  #   sign_in @user_admin
  #   bulletin = bulletins(:published)
  #   patch archive_admin_bulletin_path(bulletin)
  #   assert { bulletin.reload.archived? }
  #   assert_response :redirect
  # end

  # test 'should reject bulletin' do
  #   sign_in @user_admin
  #   patch reject_admin_bulletin_path(@bulletin)
  #   assert { @bulletin.reload.rejected? }
  #   assert_response :redirect
  # end
end