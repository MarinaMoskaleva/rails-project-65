# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    return redirect_to root_path, notice: t('already_signed_in') if signed_in?

    req_info = request.env['omniauth.auth'][:info]
    auth_hash_params = {
      email: req_info[:email],
      name: req_info[:name]
    }
    user = find_or_create_user(auth_hash_params)
    make_user_admin(user) # remove after check!
    sign_in user
    flash[:notice] = t('flash.notice.success')
    redirect_to root_path
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private

  def find_or_create_user(auth_hash_params)
    user = User.find_by(email: auth_hash_params[:email])
    user ||= User.create!(auth_hash_params)
    user.update(name: auth_hash_params[:name]) if user.name != auth_hash_params[:name]
    user
  end

  def make_user_admin(user)
    user.admin = true
    user.save!
  end
end
