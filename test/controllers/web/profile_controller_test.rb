# frozen_string_literal: true

require 'test_helper'

class Web::ProfileControllerTest < ActionDispatch::IntegrationTest
  test 'check if authentificated' do
    get profile_path
    assert_response :redirect
  end

  test 'should get index' do
    sign_in users(:one)
    get profile_path
    assert_response :success
  end
end
