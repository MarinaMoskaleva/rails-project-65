# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    req_info = request.env['omniauth.auth'][:info]
    auth_hash_params = {
      email: req_info[:email],
      name: req_info[:name]
    }
    user = find_or_create_user(auth_hash_params)
    make_user_admin(user) # remove after check!
    log_in_and_redirect(user)
  end

  def destroy
    if session[:user_id].present?
      session[:user_id] = nil
      flash[:notice] = t('flash.notice.success')
    end
    redirect_to root_path
  end

  private

  def find_or_create_user(auth_hash_params)
    user = User.find_by(auth_hash_params)
    user || User.create!(auth_hash_params)
  end

  def make_user_admin(user)
    user.admin = true
    user.save!
  end

  def log_in_and_redirect(user)
    session[:user_id] = user.id
    flash[:notice] = t('flash.notice.success')
    redirect_to root_path
  end
end
