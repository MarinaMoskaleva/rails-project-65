# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    return redirect_to root_path, notice: t('already_signed_in') if signed_in?

    req_info = request.env['omniauth.auth'][:info]
    auth_hash_params = {
      email: req_info[:email],
      name: req_info[:name]
    }
    user = User.find_or_initialize_by(email: auth_hash_params[:email])
    user.update(name: auth_hash_params[:name])
    sign_in user
    flash[:notice] = t('flash.notice.success')
    redirect_to root_path
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
