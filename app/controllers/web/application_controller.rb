# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def check_if_user_authorized
    return unless session[:user_id].nil?

    flash[:notice] = t('user_must_be_authorized')
    redirect_to root_path
  end

  def user_not_authorized
    flash[:alert] = t('user_not_authorized')
    redirect_to(request.referer || root_path)
  end
end
