# frozen_string_literal: true

class Web::Admin::ApplicationController < Web::ApplicationController
  before_action :authorize_admin

  def authorize_admin
    return if current_user&.admin?

    flash[:notice] = t('for_admins_only')
    redirect_to root_path
  end
end
