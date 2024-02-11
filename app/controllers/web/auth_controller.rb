# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    auth_hash_params = {
      email: request.env['omniauth.auth'][:info][:email],
      name: request.env['omniauth.auth'][:info][:name]
    }
    user = User.find_by(auth_hash_params)

    user = User.create!(auth_hash_params) if user.nil?

    user.admin = true
    user.save!

    session[:user_id] = user.id
    flash[:notice] = t('flash.notice.success')
    redirect_to root_path
  end

  def destroy
    if session[:user_id].present?
      session[:user_id] = nil
      flash[:notice] = t('flash.notice.success')
    end
      redirect_to root_path
  end
end
