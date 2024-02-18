# frozen_string_literal: true

class Web::ProfileController < Web::ApplicationController
  before_action :check_if_user_authorized

  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.includes(:user).where(user: current_user).page(params[:page])
  end
end
