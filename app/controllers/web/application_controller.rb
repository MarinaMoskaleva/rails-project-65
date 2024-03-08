# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  helper_method :current_user

  def user_not_authorized
    flash[:alert] = t('user_not_authorized')
    redirect_to(request.referer || root_path)
  end
end
