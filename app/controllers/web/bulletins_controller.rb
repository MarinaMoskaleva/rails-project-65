class Web::BulletinsController < Web::ApplicationController
  before_action :check_if_user_authorized, except: [:index, :show]

  def index
    @bulletins = Bulletin.includes(:user).all
  end

  def show
    @bulletin = Bulletin.find_by(id: params[:id])
  end

  def new
    @bulletin = Bulletin.new
  end

  def create
    @bulletin = User.find_by(id: session[:user_id]).bulletins.build(bulletin_params)
      if @bulletin.save
        flash[:notice] = I18n.t('flash.notice.bulletin_created')
        redirect_to root_path
      else
        flash[:error] = I18n.t('flash.error.bulletin_not_created')
        render :new, status: :unprocessable_entity
      end
  end

  def to_moderation
    bulletin = Bulletin.find_by(id: params[:id])
    authorize bulletin
    if bulletin.may_to_moderation?
      bulletin.to_moderation!
      flash[:notice] = I18n.t('flash.notice.bulletin_sent_to_moderation')
      redirect_to profile_path
    else
      flash[:error] = I18n.t('flash.notice.bulletin_didnt_send_to_moderation')
      redirect_to profile_path
    end
  end

  def archive
    
  end

  private

    def bulletin_params
      params.require(:bulletin).permit(
        :title,
        :description,
        :category_id,
        :image
      )
    end

end
