# frozen_string_literal: true

class Web::ProfilesController < Web::ApplicationController
  before_action :authenticate_user!

  def show
    @q = current_user.bulletins.ransack(params[:q])
    @bulletins = @q.result.order(created_at: :desc).page(params[:page])
  end
end
