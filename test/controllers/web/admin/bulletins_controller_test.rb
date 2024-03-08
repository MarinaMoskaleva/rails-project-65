# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user_admin = users(:admin)
    sign_in @user_admin
  end

  test 'admin should get all bulletins' do
    get admin_bulletins_path
    assert_response :success
  end

  test 'admin should get bulletins on moderation' do
    get on_moderation_admin_bulletins_path
    assert_response :success
  end

  test 'should publish bulletin' do
    bulletin = bulletins(:under_moderation)
    patch publish_admin_bulletin_path(bulletin)
    assert { bulletin.reload.published? }
    assert_response :redirect
  end

  test 'should archive bulletin' do
    bulletin = bulletins(:published)
    patch archive_admin_bulletin_path(bulletin)
    assert { bulletin.reload.archived? }
    assert_response :redirect
  end

  test 'should reject bulletin' do
    bulletin = bulletins(:under_moderation)
    patch reject_admin_bulletin_path(bulletin)
    assert { bulletin.reload.rejected? }
    assert_response :redirect
  end
end
