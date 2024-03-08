# frozen_string_literal: true

require 'test_helper'

class Web::AuthControllerTest < ActionDispatch::IntegrationTest
  test 'should get auth github' do
    post auth_request_path(:github)
    assert_response :redirect
  end

  test 'should login' do
    auth_hash = {
      provider: 'github',
      uid: '12345',
      info: {
        email: Faker::Internet.email,
        name: Faker::Name.first_name
      }
    }

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash::InfoHash.new(auth_hash)

    get callback_auth_path('github')
    assert_response :redirect

    user = User.find_by!(email: auth_hash[:info][:email].downcase)

    assert user
    assert signed_in?
  end

  test 'should logout' do
    sign_in users(:one)
    delete auth_logout_path
    assert { session[:user_id].nil? }
    assert_redirected_to root_path
  end
end
