# frozen_string_literal: true

class Web::ProfilesController < Web::ApplicationController
  before_action :check_if_user_authorized

  def show
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.includes(:user).where(user: current_user).order(created_at: :desc).page(params[:page])
  end
end
