# frozen_string_literal: true

class Web::Admin::ApplicationController < Web::ApplicationController
  before_action :authorise_admin

  def authorise_admin
    current_user&.admin?
  end

end
