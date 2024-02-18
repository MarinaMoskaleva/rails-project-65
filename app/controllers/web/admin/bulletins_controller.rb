# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  before_action :set_bulletin, only: %i[publish archive reject]

  def index
    @bulletins = Bulletin.includes(:user).page(params[:page])
  end

  def show
    @bulletin = Bulletin.find_by(id: params[:id])
  end

  def publish
    bulletin = set_bulletin
    authorize bulletin
    if bulletin.may_publish?
      bulletin.publish!
      flash[:notice] = I18n.t('flash.notice.bulletin_was_published')
    else
      flash[:error] = I18n.t('flash.notice.bulletin_wasnt_published')
    end
    redirect_to admin_root_path
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
    redirect_to admin_root_path
  end

  def reject
    bulletin = set_bulletin
    authorize bulletin
    if bulletin.may_reject?
      bulletin.reject!
      flash[:notice] = I18n.t('flash.notice.bulletin_was_rejected')
    else
      flash[:error] = I18n.t('flash.notice.bulletin_wasnt_rejected')
    end
    redirect_to admin_root_path
  end

  def on_moderation
    @bulletins = Bulletin.under_moderation.page(params[:page])
  end

  private

  def set_bulletin
    Bulletin.find_by(id: params[:id])
  end
end
