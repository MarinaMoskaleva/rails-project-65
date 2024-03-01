# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :check_if_user_authorized, except: %i[index show]
  before_action :set_bulletin, only: %i[to_moderation archive edit update]

  def index
    @q = Bulletin.published.ransack(params[:q])
    @bulletins = @q.result.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def show
    @bulletin = Bulletin.find_by(id: params[:id])
    authorize @bulletin
  end

  def new
    @bulletin = Bulletin.new
  end

  def edit
    @bulletin = set_bulletin
    authorize @bulletin
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

  def update
    @bulletin = set_bulletin
    if @bulletin.update(bulletin_params)
      flash[:notice] = I18n.t('flash.notice.bulletin_updated')
      redirect_to root_path
    else
      flash[:error] = I18n.t('flash.error.bulletin_not_updated')
      render :edit, status: :unprocessable_entity
    end
  end

  def to_moderation
    bulletin = set_bulletin
    authorize bulletin
    if bulletin.may_to_moderation?
      bulletin.to_moderation!
      flash[:notice] = I18n.t('flash.notice.bulletin_sent_to_moderation')
    else
      flash[:error] = I18n.t('flash.notice.bulletin_didnt_send_to_moderation')
    end
    redirect_to profile_path
  end

  def archive
    bulletin = set_bulletin
    authorize bulletin
    if bulletin.may_archive?
      bulletin.archive!
      flash[:notice] = I18n.t('flash.notice.bulletin_sent_to_archive')
    else
      flash[:error] = I18n.t('flash.notice.bulletin_didnt_send_to_archive')
    end
    redirect_to profile_path
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

  def set_bulletin
    Bulletin.find_by(id: params[:id])
  end
end
