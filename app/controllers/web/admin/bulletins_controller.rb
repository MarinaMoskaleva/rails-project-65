class Web::Admin::BulletinsController < Web::Admin::ApplicationController

  def index
    @bulletins = Bulletin.includes(:user).all
  end

  def show
    @bulletin = Bulletin.find_by(id: params[:id])
  end

end
